/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontController;

import com.as.practica2.object.Policy;
import com.as.practica2.object.Receipt;
import com.as.practica2.stateful.PolicyBean;
import com.as.practica2.stateful.ReceiptBean;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jorge
 */
public class Receipts extends FrontCommand {

    @Override
    public void process() {
        try {
            currentPolicy();
            addReceipt();
            //chargeReceipt();
            forward("/receipts.jsp");
        } catch (ServletException | IOException ex) {
            Logger.getLogger(UnknownCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void chargeReceipt() {
        if (request.getParameter("charged") != null) {
            HttpSession session = request.getSession(true);
            List<String> clientData = (List<String>) session.getAttribute("clientData");
            PolicyBean policyList = (PolicyBean) session.getAttribute("policyList");
            policyList.addPolicy(clientData.get(2), new Policy(request.getParameter("id"), request.getParameter("type"), request.getParameter("from"), request.getParameter("to"), request.getParameter("payRange"), request.getParameter("price")), (String) session.getAttribute("user"));
            session.setAttribute("policyList", policyList);
        }
    }

    public void currentPolicy() {
        HttpSession session = request.getSession(true);
        System.out.println(request.getParameter("idPolicy"));
        if (request.getParameter("idPolicy") != null) {
            System.out.println(request.getParameter("idPolicy"));
            session.setAttribute("currentPolicy", request.getParameter("idPolicy"));
        }
    }

    public void addReceipt() {
        if (request.getParameter("addReceipt") != null) {
            HttpSession session = request.getSession(true);
            ReceiptBean receiptList = (ReceiptBean) session.getAttribute("receiptList");
            String currentPolicy = (String) session.getAttribute("currentPolicy");
            System.out.println("LO AÑADO A ESTA POLIZA " + currentPolicy);

            receiptList.addReceipt(currentPolicy, new Receipt(request.getParameter("id"), request.getParameter("date"), request.getParameter("amount"), Boolean.valueOf(request.getParameter("paid"))), (String) session.getAttribute("user"));
            session.setAttribute("receiptList", receiptList);
        }
    }
}
