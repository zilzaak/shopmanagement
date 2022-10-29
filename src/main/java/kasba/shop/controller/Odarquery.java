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
import kasba.shop.helper.Masikodar;
import kasba.shop.helper.Masiksell;
import kasba.shop.model.Odar;
import kasba.shop.model.Sell;
import kasba.shop.repo.Odarrepo;

@Controller
@RequestMapping("/odarquery")
public class Odarquery {
	@Autowired
	private Odarrepo orr;
	
	
	@PostMapping("/odarinamonth")
	public ResponseEntity<Masikodar> odarinamonth(@RequestBody String[] asik) throws ParseException{
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

List<Odar> lst=orr.findByOrderdateBetween(d,d2);
Masikodar ms=new Masikodar();
float totalodar=0;
for(Odar s:lst){
		totalodar=totalodar+s.getTotalprice();
	
}
ms.setTotalodar(totalodar);ms.setOdars(lst);
return new ResponseEntity<Masikodar>(ms,HttpStatus.OK);

}
	
	
@GetMapping("/todaysodar")
	public ResponseEntity<Masikodar> todayssell() throws ParseException{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date d =sdf.parse(sdf.format(new Date()));
    
	List<Odar> lst=orr.findByOrderdate(d);
	Masikodar ms=new Masikodar();
	float totalsell=0;

	for(Odar s:lst){
		totalsell=totalsell+s.getTotalprice();
	
		}
	ms.setTotalodar(totalsell);
	ms.setOdars(lst);
	return new ResponseEntity<Masikodar>(ms,HttpStatus.OK);


}	
	

@GetMapping("/odarinadate")
public ResponseEntity<Masikodar> odarinadate(@RequestBody String asik) throws ParseException{
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Date d =sdf.parse(asik);
List<Odar> lst=orr.findByOrderdate(d);
Masikodar ms=new Masikodar();
float totalsell=0;

for(Odar s:lst){
	totalsell=totalsell+s.getTotalprice();

	}
ms.setTotalodar(totalsell);
ms.setOdars(lst);
return new ResponseEntity<Masikodar>(ms,HttpStatus.OK);

}	
	

@GetMapping("/odarafteradate")
public ResponseEntity<Masikodar> odarafterdate(@RequestBody String asik) throws ParseException{
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Date d =sdf.parse(asik);
List<Odar> lst=orr.findByOrderdate(d);
Masikodar ms=new Masikodar();
float totalsell=0;

for(Odar s:lst){
	totalsell=totalsell+s.getTotalprice();

	}
ms.setTotalodar(totalsell);
ms.setOdars(lst);
return new ResponseEntity<Masikodar>(ms,HttpStatus.OK);

}


}
