package kasba.shop.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.YearMonth;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kasba.shop.helper.Masiksell;
import kasba.shop.repo.Sellingrepo;
import kasba.shop.model.*;

@RequestMapping("/sellquery")
@Controller
public class Sellquery {
	@Autowired
	private Sellingrepo slr;
	
@PostMapping("/sellinamonth")
	public ResponseEntity<Masiksell> costprofitinamonth(@RequestBody String[] asik) throws ParseException{
		if(asik[0].contentEquals("january")) {
			asik[0]="01";
		}
		if(asik[0].contentEquals("february")) {
			asik[0]="02";
		}
		if(asik[0].contentEquals("march")) {
			asik[0]="03";
		}
		if(asik[0].contentEquals("april")) {
			asik[0]="04";
		}
		if(asik[0].contentEquals("may")) {
			asik[0]="05";
		}
		if(asik[0].contentEquals("june")) {
			asik[0]="06";
		}
		if(asik[0].contentEquals("july")) {
			asik[0]="07";
		}
		if(asik[0].contentEquals("august")) {
			asik[0]="08";
		}
		if(asik[0].contentEquals("september")) {
			asik[0]="09";
		}
		if(asik[0].contentEquals("october")) {
			asik[0]="10";
		}
		if(asik[0].contentEquals("november")) {
			asik[0]="11";
		}
		if(asik[0].contentEquals("december")) {
			asik[0]="12";
		}

		YearMonth yearMonthObject = YearMonth.of(Integer.parseInt(asik[1]),Integer.parseInt(asik[0]));
		int daysInMonth = yearMonthObject.lengthOfMonth();  
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
String dt = "01"+"/"+asik[0]+"/"+asik[1];
String dt2=String.valueOf(daysInMonth)+"/"+asik[0]+"/"+asik[1];
Date d = sdf.parse(dt);
Date d2 = sdf.parse(dt2);

List<Sell> lst=slr.findBySelldateBetween(d,d2);
Masiksell ms=new Masiksell();
float totalsell=0;
float totaldue=0;
for(Sell s:lst){
	totalsell=totalsell+s.getTotalprice();
	totaldue=totaldue+s.getDue();
	
}
ms.setTotalsell(totalsell);ms.setTotaldue(totaldue);ms.setSells(lst);
return new ResponseEntity<Masiksell>(ms,HttpStatus.OK);

}


@GetMapping("/todayssell")
public ResponseEntity<Masiksell> todayssell() throws ParseException{
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Date d =sdf.parse(sdf.format(new Date()));
List<Sell> lst=slr.findBySelldate(d);Masiksell ms=new Masiksell();
float totalsell=0;
float totaldue=0;
for(Sell s:lst){
	totalsell=totalsell+s.getTotalprice();
	totaldue=totaldue+s.getDue();
	
}
ms.setTotalsell(totalsell);ms.setTotaldue(totaldue);
ms.setSells(lst);
return new ResponseEntity<Masiksell>(ms,HttpStatus.OK);

}


@PostMapping("/bycustomername")
public ResponseEntity<Masiksell> bycustomername(@RequestBody String asik){
	List<Sell> lst=slr.findByCustomernameContainingIgnoreCase(asik);
	Masiksell ms=new Masiksell();
	float totalsell=0;
	float totaldue=0;
	for(Sell s:lst){
		totalsell=totalsell+s.getTotalprice();
		totaldue=totaldue+s.getDue();
		}
	ms.setTotalsell(totalsell);ms.setTotaldue(totaldue);
	ms.setSells(lst);
	return new ResponseEntity<Masiksell>(ms,HttpStatus.OK);
}

	
	@PostMapping("/bycustomerphone")
	public ResponseEntity<Masiksell> bycustomerphone(@RequestBody String asik){
		List<Sell> lst=slr.findByCustomerphoneContainingIgnoreCase(asik);
		Masiksell ms=new Masiksell();
		float totalsell=0;
		float totaldue=0;
		for(Sell s:lst){
			totalsell=totalsell+s.getTotalprice();
			totaldue=totaldue+s.getDue();
					}
		
		ms.setTotalsell(totalsell);ms.setTotaldue(totaldue);
		ms.setSells(lst);
		return new ResponseEntity<Masiksell>(ms,HttpStatus.OK);
	}
	
	@PostMapping("/customerbyname")
	public ResponseEntity<List<Sell>> customerbyname(@RequestBody String asik){
		List<Sell> lst=slr.distinctname(asik);
		
		return new ResponseEntity<List<Sell>>(lst,HttpStatus.OK);
		
	}

	@PostMapping("/customerbyphone")
	public ResponseEntity<List<Sell>> customerbyphone(@RequestBody String asik){
		List<Sell> lst=  slr.distinctphone(asik);
		return new ResponseEntity<List<Sell>>(lst,HttpStatus.OK);
		
	}

}
