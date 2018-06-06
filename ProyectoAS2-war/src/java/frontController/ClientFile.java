/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontController;

import com.as.practica2.Policy;
import com.as.practica2.PolicyBean;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jorge
 */
public class ClientFile extends FrontCommand {

    public void addClient() {
        if (request.getParameter("addPolicy") != null) {
            HttpSession session = request.getSession(true);
            PolicyBean policyList = (PolicyBean) session.getAttribute("policyList");
            policyList.addPolicy("00000000", new Policy(request.getParameter("id"), request.getParameter("type"), request.getParameter("from"), request.getParameter("to"), request.getParameter("payRange"), request.getParameter("price")));
            session.setAttribute("policyList", policyList);
        }
    }

    @Override
    public void process() {
        try {
            addClient();
            forward("/clientFile.jsp");
        } catch (ServletException | IOException ex) {
            Logger.getLogger(UnknownCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
