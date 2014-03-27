package org.tnt.pt.service.costcalculator;

import java.util.List;


public class WSClient {

	/**
	 * wsimport -s ./src
	 * http://164.39.68.146:9090/smacs_sso/services/CostCalculator?wsdl -extension
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		CostCalculator_Service service = new CostCalculator_Service();
		CostCalculator cc = service.getCostCalculatorPort();
		List<String> r;
//		r = cc.getTotalCosts("55323", "2013-10-25", "SP", "CN", "HGH", "US", "BOS", "15N", "82.3521", "3", "2", "H", "0OKM,[uytgh98}TR54", "");
		
		r = cc.getTotalCosts("55323", "2014-01-20", "SP", "CN", "SHA", "HK", "HKG", "15N", "0.5", "0.5", "1", "L", "0OKM,[uytgh98}TR54", "SHA"); 
		
		System.out.println(r);
	}

}