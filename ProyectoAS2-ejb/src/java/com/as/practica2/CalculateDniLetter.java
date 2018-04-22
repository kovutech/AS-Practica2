/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.as.practica2;

import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;

/**
 *
 * @author Jorge
 */
@Stateless
@LocalBean
public class CalculateDniLetter {

    @PostConstruct
    public void CalculateDniLetter() {
    }

    public String getDniLetter(String str) {
        char[] LETTERS = {'T', 'R', 'W', 'A', 'G', 'M', 'Y', 'F', 'P', 'D', 'X', 'B', 'N', 'J', 'Z', 'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E'};
        if (str.matches("[0-9]{8}")) {
            int num = Integer.parseInt(str.replaceAll("[^0-9]", ""));
            return "" + LETTERS[num % LETTERS.length];
        }
        return "-";
    }
}