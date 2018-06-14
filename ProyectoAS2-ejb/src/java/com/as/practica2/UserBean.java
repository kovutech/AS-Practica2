/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.ejb.LocalBean;
import javax.ejb.Stateful;

/**
 *
 * @author Jorge
 */
@Stateful
@LocalBean
public class UserBean {

    Map<String, List<User>> map = new HashMap<String, List<User>>();

    @PostConstruct
    public void UserBean() {
    }

    public void addUser(String user, User userAux) {
        List<User> aux;
        if (map.containsKey(user)) {
            aux = map.get(user);
        } else {
            aux = new ArrayList<User>();
        }
        aux.add(userAux);
        map.put(user, aux);
    }

    public List<User> getUserList(String user) {
        List<User> aux;
        if (map.containsKey(user)) {
            aux = map.get(user);
        } else {
            aux = new ArrayList<User>();
        }
        return aux;
    }
}
