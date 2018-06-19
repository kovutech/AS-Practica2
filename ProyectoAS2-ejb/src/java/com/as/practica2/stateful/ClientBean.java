/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2.stateful;

import com.as.practica2.object.Client;
import com.as.practica2.singleton.LogBean;
import com.as.practica2.singleton.StadisticsBean;
import com.as.practica2.stateful.ClientBean;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Stateful;
import javax.ejb.LocalBean;
import javax.ejb.PostActivate;
import javax.ejb.PrePassivate;
import javax.ejb.Remove;
import javax.naming.InitialContext;
import javax.naming.NamingException;

@Stateful
@LocalBean
public class ClientBean {

    private File file;
    private PrintWriter writing;
    private FileWriter fWritting;
    private boolean print = false;
    private LogBean log;
    private StadisticsBean stadistics;

    List<Client> client = new ArrayList<Client>();

    @PostConstruct
    public void ClientBean() {
        try {
            file = new File("C:\\Users\\Jorge\\Desktop\\AS\\Practica2\\stateful1.txt");
            fWritting = new FileWriter(file, true);
            writing = new PrintWriter(fWritting);
            writing.println("ClientBean::PostConstruct::ClientBean");
            close();
            print = true;
            log = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/LogBean");
            log.addFuntion("ClientBean::PostConstruct");
            stadistics = InitialContext.doLookup("java:global/ProyectoAS2/ProyectoAS2-ejb/StadisticsBean");
            stadistics.addComponent("ClientBean");

        } catch (IOException | NamingException ex) {
            log.addFuntion("ClientBean::Excepción PostConstruct");
            Logger.getLogger(ClientBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addClient(Client clientAux, String user) {
        stadistics.addComponentUsers(user);
        log.addFuntion("ClientBean::addClient");
        stadistics.addComponent("ClientBean");
        setText("ClientBean", "addClient", user);
        client.add(clientAux);
    }

    public void deleteClient(String id, String user) {
        stadistics.addComponentUsers(user);
        log.addFuntion("ClientBean::deleteClient");
        stadistics.addComponent("ClientBean");
        setText("ClientBean", "deleteClient", user);
        for (int i = 0; i < client.size(); i++) {
            if (client.get(i).getId().equals(id)) {
                client.remove(i);
            }
        }
    }

    public List<Client> getClientList(String user) {
        stadistics.addComponentUsers(user);
        log.addFuntion("ClientBean::getClientList");
        stadistics.addComponent("ClientBean");
        setText("ClientBean", "getClientList", user);
        return client;
    }
    
    public void setText(String clase, String metodo, String usuario) {
        if (print) {
            try {
                file = new File("C:\\Users\\Jorge\\Desktop\\AS\\Practica2\\stateful1.txt");
                fWritting = new FileWriter(file, true);
                writing = new PrintWriter(fWritting);
                String mensaje = clase + "::" + metodo + "::" + usuario;
                writing.println(mensaje);
                close();
            } catch (IOException ex) {
                log.addFuntion("ClientBean::Error al escribir en el documento.");
                Logger.getLogger(ClientBean.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @PostActivate
    public void postActivate() {
        stadistics.addComponent("ClientBean");
        log.addFuntion("ClientBean::PostActivate");
        setText("ClientBean", "PostActivate", "postActivate");
    }

    @PrePassivate
    public void prePassivate() {
        stadistics.addComponent("ClientBean");
        log.addFuntion("ClientBean::PrePassivate");
        setText("ClientBean", "PrePassivate", "prePassivate");
    }

    @PreDestroy
    public void preDestroy() {
        stadistics.addComponent("ClientBean");
        log.addFuntion("ClientBean::PreDestroy");
        setText("ClientBean", "PreDestroy", "preDestroy");

    }

    @Remove
    public void remove() {
        stadistics.addComponent("ClientBean");
        log.addFuntion("ClientBean::Remove");
        setText("ClientBean", "Remove", "remove");
        close();
    }

    public void close() {
        try {
            fWritting.close();
            writing.close();

        } catch (IOException ex) {
            log.addFuntion("ClientBean::Excepción cerrando el documento");
            Logger.getLogger(ClientBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
