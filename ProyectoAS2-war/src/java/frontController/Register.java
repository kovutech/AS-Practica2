/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontController;

import com.as.practica2.User;
import com.as.practica2.UserBean;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jorge
 */
public class Register extends FrontCommand {

    @Override
    public void process() {
        try {
            addUser();
            forward("/index.jsp");
        } catch (ServletException | IOException ex) {
            Logger.getLogger(UnknownCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addUser() {
        HttpSession session = request.getSession(true);
        UserBean userList = (UserBean) session.getAttribute("userList");
        userList.addUser(request.getParameter("name"), new User(request.getParameter("name"), request.getParameter("pass"), request.getParameter("email")));
        session.setAttribute("userList", userList);
        session.removeAttribute("user");
    }
}