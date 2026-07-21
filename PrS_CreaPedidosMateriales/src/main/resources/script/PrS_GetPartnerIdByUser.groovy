/* 
 * PrS_GetPartnerIdByUser.groovy
 * 
 * This script gets the partner id by authorized user then it get specific 
 * properties. If sender uses a service key, the authorized corresponds to 
 * the client_id.  
 */
 import com.sap.gateway.ip.core.customdev.util.Message
 import com.sap.it.api.pd.PartnerDirectoryService
 import com.sap.it.api.ITApiFactory
 
 def Message processData(Message message) {
 
	 def service = ITApiFactory.getApi(PartnerDirectoryService.class, null)
	 
	 // get username
	 def userName = message.getHeaders().get("SapAuthenticatedUserName")
	 if (userName == null) {
		 throw new IllegalStateException(
			 "Logged-in user not available in header SapAuthenticatedUserName."
		   + " Consider to include 'SapAuthenticatedUserName' as an allowed "
		   + "header in the runtime configuration of the integration flow.");
	 }
 
    // get sender partner id
	def senderPartnerId = service.getPartnerIdOfAuthorizedUser(userName)
	if (senderPartnerId == null ) {
		 throw new IllegalStateException("No partner ID found for user "+ userName);
	}
	message.setProperty("v_senderPid", senderPartnerId)

    // get receiver partner id
	def receiverPartnerId = service.getParameter("ReceiverPID", senderPartnerId, java.lang.String.class) 
	if (receiverPartnerId == null ) {
		 throw new IllegalStateException("Missing property ReceiverPID for partner '"+ senderPartnerId + "'");
	}
	message.setProperty("v_receiverPid", receiverPartnerId)
	 
	 // retrieve specific sender parameters
	 def senderName = service.getParameter("PartnerName", senderPartnerId, java.lang.String.class) 
	 def extensionProcessPath = service.getParameter("ExtensionProcessPath", senderPartnerId, java.lang.String.class)
	 def pedidoReqMM = service.getParameter("pedidoReqMM", senderPartnerId, java.lang.String.class)
	 def defaultPedidoReqMM = message.getProperty("p_defaultPedidoReqMM")
	 def pedidoRespMM = service.getParameter("pedidoRespMM", senderPartnerId, java.lang.String.class)
	 def defaultPedidoRespMM = message.getProperty("p_defaultPedidoRespMM")
	 message.setProperty("v_senderName", senderName)
	 message.setProperty("v_extensionProcessPath", extensionProcessPath)
	 message.setProperty("v_pedidoReqMM", "ref:" + (pedidoReqMM == null ? defaultPedidoReqMM : pedidoReqMM))
	 message.setProperty("v_pedidoRespMM", "ref:" + (pedidoRespMM == null ? defaultPedidoRespMM : pedidoRespMM))

	 // retrieve specific receiver parameters
	 def receiverName = service.getParameter("PartnerName", receiverPartnerId, java.lang.String.class) 
	 def zycusCredentials = service.getParameter("APICredentials", receiverPartnerId, java.lang.String.class)
	 def zycusHostname = service.getParameter("hostname", receiverPartnerId, java.lang.String.class)
	 def zycusPort = service.getParameter("port", receiverPartnerId, java.lang.String.class)
	 message.setProperty("v_receiverName", receiverName)
	 message.setProperty("v_zycusCredentials", zycusCredentials)
	 message.setProperty("v_zycusHostname", zycusHostname)
	 message.setProperty("v_zycusPort", zycusPort)
	 
	 return message;
 }