/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontController;

import com.as.practica2.Policy;
import com.as.practica2.PolicyBean;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jorge
 */
public class Policies extends FrontCommand {

    public void addClient() {
        if (request.getParameter("addPolicy") != null) {
            HttpSession session = request.getSession(true);
            List<String> clientData = (List<String>) session.getAttribute("clientData");
            PolicyBean policyList = (PolicyBean) session.getAttribute("policyList");
            policyList.addPolicy(clientData.get(2), new Policy(request.getParameter("id"), request.getParameter("type"), request.getParameter("from"), request.getParameter("to"), request.getParameter("payRange"), request.getParameter("price")));
            session.setAttribute("policyList", policyList);
        }
    }

    @Override
    public void process() {
        try {
            newClientSession();
            addClient();
            forward("/policies.jsp");
        } catch (ServletException | IOException ex) {
            Logger.getLogger(UnknownCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void newClientSession() {
        if (request.getParameter("listPolicy") != null) {
            System.out.println("ESTOY ACTUALIZANDO CLIENTDATA!");
            HttpSession session = request.getSession(true);
            List<String> clientData = new ArrayList<String>();
            clientData.add(request.getParameter("nombre"));
            clientData.add(request.getParameter("apellido"));
            clientData.add(request.getParameter("dni"));
            session.setAttribute("clientData", clientData);
            System.out.println(Arrays.toString(clientData.toArray()));
        }
    }
}