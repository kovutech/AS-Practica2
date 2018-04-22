/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.Stateful;
import javax.ejb.LocalBean;

@Stateful
@LocalBean
public class ClientBean {

    List<Client> client = new ArrayList<Client>();

    @PostConstruct
    public void ClientBean() {
    }

    public void addClient(Client clientAux) {
        client.add(clientAux);
    }

    public void deleteClient(Client clientAux) {
        client.remove(clientAux);
    }

    public List<Client> getClientList() {
        return client;
    }
}
