/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontController;

import com.as.practica2.ClientBean;
import com.as.practica2.Client;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jorge
 */
public class Main extends FrontCommand {

    public void addClient() {
        if (request.getParameter("addClient") != null) {
            HttpSession session = request.getSession(true);
            ClientBean clientList = (ClientBean) session.getAttribute("clientList");
            clientList.addClient(new Client(request.getParameter("dni"), request.getParameter("nombre"), request.getParameter("apellido"), request.getParameter("telefono")));
            session.setAttribute("clientList", clientList);
        }
    }

    public void deleteClient() {
        
        if (request.getParameter("deleteClient") != null) {
            HttpSession session = request.getSession(true);
            ClientBean clientList = (ClientBean) session.getAttribute("clientList");
            clientList.deleteClient(request.getParameter("deleteClient"));
            session.setAttribute("clientList", clientList);
        }
    }

    @Override
    public void process() {
        try {
            addClient();
            deleteClient();
            forward("/main.jsp");
        } catch (ServletException | IOException ex) {
            Logger.getLogger(UnknownCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
