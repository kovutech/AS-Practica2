/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2.stateful;

import com.as.practica2.object.Policy;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.ejb.Stateful;
import javax.ejb.LocalBean;

@Stateful
@LocalBean
public class PolicyBean {

    Map<String, List<Policy>> map = new HashMap<String, List<Policy>>();

    @PostConstruct
    public void PolicyBean() {
    }

    public void addPolicy(String id, Policy policyAux) {
        List<Policy> aux;
        if (map.containsKey(id)) {
            aux = map.get(id);
        } else {
            aux = new ArrayList<Policy>();
        }
        aux.add(policyAux);
        map.put(id, aux);
    }

    public void deletePolicy(String id, String PolicyId) {
        List<Policy> aux = new ArrayList<Policy>();
        aux = map.get(id);
        for (int i = 0; i < aux.size(); i++) {
            if (aux.get(i).getId().equals(id)) {
                aux.remove(i);
            }
        }
        map.put(id, aux);
    }

    public List<Policy> getPolicyList(String id) {
        List<Policy> aux;
        if (map.containsKey(id)) {
            aux = map.get(id);
        } else {
            aux = new ArrayList<Policy>();
        }
        return aux;
    }
}
