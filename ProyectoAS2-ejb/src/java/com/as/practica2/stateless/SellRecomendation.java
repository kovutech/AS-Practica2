package com.as.practica2.stateless;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;

@Stateless
@LocalBean
public class SellRecomendation {

    /**
     *
     * @param stringPolicies
     */
    @PostConstruct
    public void SellRecomendation() {
    }

    public List<String> getRecommendatios(List<String> stringPolicies) {
        String[] allTypesInsurances = {"Accidentes", "Ahorro", "Autos", "Decesos", "Embarcaciones", "Hogar", "Motos", "Salud", "Viajes", "Vida"};
        List<String> auxTypesInsurances = new ArrayList<String>();

        for (String elemA : allTypesInsurances) {
            Boolean bool = true;
            for (String elemB : stringPolicies) {
                if (elemA.equals(elemB)) {
                    bool = false;
                }
            }
            if (bool == true) {
                auxTypesInsurances.add(elemA);
            }
        }
        return auxTypesInsurances;
    }
}
