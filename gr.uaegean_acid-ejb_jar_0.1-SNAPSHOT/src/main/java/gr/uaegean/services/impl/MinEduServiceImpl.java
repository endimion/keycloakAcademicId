/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gr.uaegean.services.impl;

import gr.uaegean.pojo.GrantRequest;
import gr.uaegean.pojo.MinEduAmkaResponse;
import gr.uaegean.pojo.MinEduResponse;
import gr.uaegean.pojo.MinEduResponse.InspectionResult;
import gr.uaegean.pojo.TokenResponse;
import gr.uaegean.services.MinEduService;
import gr.uaegean.services.PropertiesService;
import java.time.LocalDateTime;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author nikos
 */
@Service
public class MinEduServiceImpl implements MinEduService {

    private PropertiesService paramServ;
    private final String minEduTokenUri;
    private final String minEduTokenUser;
    private final String minEduTokenPass;
    private final String minEduTokenGrantType;
    private final String minEduQueryIdEndpoint;
    private final String minEduQueryByAmkaEndpoint;
    private LocalDateTime accessTokenExpiration;
    private Optional<String> activeToken;

    private final static Logger LOG = LoggerFactory.getLogger(MinEduServiceImpl.class);

    public MinEduServiceImpl(PropertiesService paramServ) {
        this.paramServ = paramServ;
        this.minEduTokenUri = paramServ.getProp("MINEDU_TOKEN_URL");
        this.minEduTokenPass = paramServ.getProp("MINEDU_TOKEN_PASSWORD");
        this.minEduTokenUser = paramServ.getProp("MINEDU_TOKEN_USERNAME");
        this.minEduTokenGrantType = paramServ.getProp("MINEDU_TOKEN_GRANTTYPE");
        this.minEduQueryIdEndpoint = paramServ.getProp("MINEDU_QUERYID_URL");
        this.minEduQueryByAmkaEndpoint = paramServ.getProp("MINEDU_QUERY_BY_AMKA"); //https://gateway.interoperability.gr/academicId/1.0.1/student/
        this.accessTokenExpiration = LocalDateTime.now();
        this.activeToken = Optional.empty();
    }

    @Override
    public Optional<String> getAccessToken() {
        GrantRequest grantReq = new GrantRequest(minEduTokenUser, minEduTokenPass, minEduTokenGrantType);
        RestTemplate restTemplate = new RestTemplate();
        LOG.info("will get toke from theurl: " + minEduTokenUri);

        try {
            if (activeToken.isPresent() && accessTokenExpiration.isAfter(LocalDateTime.now().plusSeconds(30))) {
                LOG.info("MinEdu OAth token still alive " + activeToken.get());
                return activeToken;
            } else {
                LOG.info("will get new token ");
                TokenResponse tokResp = restTemplate.postForObject(minEduTokenUri, grantReq, TokenResponse.class);
                if (tokResp != null && tokResp.getSuccess().equals("true") && tokResp.getOauths() != null && tokResp.getOauths()[0].getOauth().getAccessToken() != null) {
                    LOG.info("retrieved token " + tokResp.getOauths()[0].getOauth().getAccessToken());
                    this.accessTokenExpiration = this.accessTokenExpiration.plusSeconds(tokResp.getOauths()[0].getOauth().getExpiresIn());
                    this.activeToken = Optional.of(tokResp.getOauths()[0].getOauth().getAccessToken());
                    return this.activeToken;
                }

            }

        } catch (HttpClientErrorException e) {
            LOG.error(e.getMessage());
        }

        return Optional.empty();
    }

    @Override
    public Optional<InspectionResult> getInspectioResultByAcademicId(String academicId, String selectedUniversityId, String esmoSessionId) {
        String minEduQueryIdUrl = this.minEduQueryIdEndpoint + "?id=" + academicId + "&username=" + this.minEduTokenUser + "&password=" + this.minEduTokenPass;
        HttpHeaders requestHeaders = new HttpHeaders();
        Optional<String> accessToken = getAccessToken();
        if (accessToken.isPresent()) {
            RestTemplate restTemplate = new RestTemplate();
            requestHeaders.add("Authorization", "Bearer " + accessToken.get());
            HttpEntity<?> entity = new HttpEntity<>(requestHeaders);
            LOG.info("querying for academicId " + academicId);
            try {
                ResponseEntity<MinEduResponse> queryId = restTemplate.exchange(minEduQueryIdUrl, HttpMethod.GET, entity, MinEduResponse.class);
                MinEduResponse qResp = queryId.getBody();
                InspectionResult ir = qResp.getResult().getInspectionResult();
                return Optional.of(ir);
            } catch (HttpClientErrorException e) {
                LOG.error(e.getMessage());
            }

        }
        LOG.error("no token found in response!");
        return Optional.empty();
    }

    @Override
    public Optional<String> getAcademicIdFromAMKA(String amkaNumber, String selectedUniversityId, String esmoSessionId) {
        String requestUrl = this.minEduQueryByAmkaEndpoint + "/" + amkaNumber + "?fields=academicID&username=" + this.minEduTokenUser + "&password=" + this.minEduTokenPass;
        HttpHeaders requestHeaders = new HttpHeaders();
        Optional<String> accessToken = getAccessToken();
        if (accessToken.isPresent()) {
            LOG.info("querying for amka " + amkaNumber);
            LOG.info("will query amka in theurl: " + requestUrl);
            RestTemplate restTemplate = new RestTemplate();
            requestHeaders.add("Authorization", "Bearer " + accessToken.get());
            HttpEntity<?> entity = new HttpEntity<>(requestHeaders);
            try {
                ResponseEntity<MinEduAmkaResponse> queryResponse = restTemplate.exchange(requestUrl, HttpMethod.GET, entity, MinEduAmkaResponse.class);
                LOG.info("result " + queryResponse.getBody().getResult().getAcademicID());

                if (queryResponse.getBody().isSuccess()) {
                    if (queryResponse.getBody().getResult() != null && queryResponse.getBody().getResult().getAcademicID() != null) {
                        return Optional.of(queryResponse.getBody().getResult().getAcademicID());
                    }
                    LOG.error("no acadmic id found for amka " + amkaNumber);
                }
            } catch (HttpClientErrorException e) {
                LOG.error(e.getMessage());
            }
        }
        LOG.error("no token found in response!");
        return Optional.empty();
    }

    @Override
    public Optional<MinEduResponse> getInspectioResponseByAcademicId(String academicId, String selectedUniversityId, String esmoSessionId) {
        String minEduQueryIdUrl = this.minEduQueryIdEndpoint + "?id=" + academicId + "&username=" + this.minEduTokenUser + "&password=" + this.minEduTokenPass;
        HttpHeaders requestHeaders = new HttpHeaders();
        Optional<String> accessToken = getAccessToken();
        if (accessToken.isPresent()) {
            RestTemplate restTemplate = new RestTemplate();
            requestHeaders.add("Authorization", "Bearer " + accessToken.get());
            HttpEntity<?> entity = new HttpEntity<>(requestHeaders);
            LOG.info("querying for academicId " + academicId);
            try {
                ResponseEntity<MinEduResponse> queryId = restTemplate.exchange(minEduQueryIdUrl, HttpMethod.GET, entity, MinEduResponse.class);
                MinEduResponse qResp = queryId.getBody();
                return Optional.of(qResp);
            } catch (HttpClientErrorException e) {
                LOG.error(e.getMessage());
            }
        }
        LOG.error("no token found in response!");
        return Optional.empty();
    }

}
