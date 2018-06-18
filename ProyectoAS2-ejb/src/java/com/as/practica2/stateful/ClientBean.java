/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2.stateful;

import com.as.practica2.object.Client;
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

    public void deleteClient(String id) {
        //for(Product p: contents){
        for (int i = 0; i < client.size(); i++) {
            if (client.get(i).getId().equals(id)) {          
                client.remove(i);
            }
        }
    }

    public List<Client> getClientList() {
        return client;
    }
}
