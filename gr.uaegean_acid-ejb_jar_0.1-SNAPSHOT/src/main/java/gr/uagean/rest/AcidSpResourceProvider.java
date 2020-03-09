package gr.uagean.rest;

import org.keycloak.models.KeycloakSession;
import org.keycloak.services.resource.RealmResourceProvider;

public class AcidSpResourceProvider implements RealmResourceProvider {

	private KeycloakSession session;

	public AcidSpResourceProvider(KeycloakSession session) {
        this.session = session;
    }

	@Override
	public Object getResource() {
		return new AcidSpRestResource(session);
	}
	
	@Override
	public void close() {
	}

}
