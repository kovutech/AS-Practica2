/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2.stateless;

import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;

/**
 *
 * @author Jorge
 */
@Stateless
@LocalBean
public class ClientLevel {

    @PostConstruct
    public void ClientLevel() {
    }

    public String getClientLevel(int numPolicies) {
        if (numPolicies >= 8) {
            return "A";
        }
        if (numPolicies >= 5) {
            return "B";
        }
        if (numPolicies >= 1) {
            return "C";
        }
        return "Sin pólizas";
    }
}