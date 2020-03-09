package gr.uaegean.pojo;

import com.fasterxml.jackson.annotation.JsonProperty;

public class TokenResponse {

    private String success;
    //Oauths
    @JsonProperty("Oauths")
    private OAuths[] oauths;

    public TokenResponse() {

    }

    public TokenResponse(String success, OAuths[] oauths) {
        this.success = success;

        this.oauths = oauths;

    }

    public String getSuccess() {
        return success;
    }

    public void setSuccess(String success) {
        this.success = success;
    }

    public OAuths[] getOauths() {
        return oauths;
    }

    public void setOauths(OAuths[] oauths) {
        this.oauths = oauths;
    }

    @Override
    public String toString() {
        return "TokenResponse{"
                + "success='" + success + '\''
                + '}';
    }

    public static class OAuths {

        @JsonProperty("TokenType")
        private String TokenType;
        private String timestamp;
        @JsonProperty("OAuth")
        private OAuth oauth;

        public OAuths() {
        }

        public OAuths(String TokenType, String timestamp, OAuth oauth) {
            this.TokenType = TokenType;
            this.timestamp = timestamp;
            this.oauth = oauth;
        }

        public String getTokenType() {
            return TokenType;
        }

        public void setTokenType(String TokenType) {
            this.TokenType = TokenType;
        }

        public String getTimestamp() {
            return timestamp;
        }

        public void setTimestamp(String timestamp) {
            this.timestamp = timestamp;
        }

        public OAuth getOauth() {
            return oauth;
        }

        public void setOauth(OAuth oauth) {
            this.oauth = oauth;
        }

    }

}
