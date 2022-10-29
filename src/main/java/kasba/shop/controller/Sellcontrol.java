package kasba.shop.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kasba.shop.model.Makeprice;
import kasba.shop.model.Psh;
import kasba.shop.model.Sell;
import kasba.shop.model.Stock;
import kasba.shop.model.Userreg;
import kasba.shop.repo.Makepricerepo;
import kasba.shop.repo.Sellingrepo;
import kasba.shop.repo.Stockrepo;
import kasba.shop.repo.Userregrepo;

@RequestMapping("/sell")
@Controller
public class Sellcontrol {
	
	@Autowired
	private Sellingrepo slr;
		@Autowired
	private Userregrepo  usr;
	@Autowired
	private Stockrepo  str;
		@Autowired
	private Makepricerepo mpr;
		List<Sell> lst=null;
		String record="";
	public void checduplicateproduct(Sell oj){
		
		int t=0;
	for(Sell k : lst) {
		if(oj.getShopid()==k.getShopid() && oj.getCompany().contentEquals(k.getCompany()) &&
				oj.getName().contentEquals(k.getName()) && oj.getCode().contentEquals(k.getCode())) {
			t++;
		}
		
	}

	if(t<1) {
	lst.add(oj);
	}
	else {
	record=record+", product name "+oj.getName()+" , code; "+oj.getCode()+" , company: "+oj.getCode()+" taken two times, remove any one record";
	}
		
	}
	
	
	
@PostMapping("/savesell")
public ResponseEntity<Sell> savesell(@RequestBody List<Sell> sellst,HttpSession session){
	
	lst = new ArrayList<Sell>();
	for(Sell o : sellst) {
		checduplicateproduct(o);	
		
	}

	Sell sd=sellst.get(0);
	if(sd==null) {
		sd.setCompany("null pointer is noticed");
		return new  ResponseEntity<Sell>(sd,HttpStatus.OK);	
	}
		if(sd.getSellto().contentEquals("")) {
			sd.setCompany("select the customer option");
			return new  ResponseEntity<Sell>(sd,HttpStatus.OK);		
		}
		
		if(sd.getStringselldate().contentEquals("") || sd.getStringselldate()==null || sd.getStringselldate().length()<10 ){
			sd.setCompany("wrong date selection");
			return new  ResponseEntity<Sell>(sd,HttpStatus.OK);		
		}	

		
	int shopid = (int) session.getAttribute("shopid");
	SimpleDateFormat sdf2= new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
	String memokey= sdf2.format(new Date());
	
	for(Sell o : lst) {
		o.setShopid(shopid);
		
		if(sd.getSellto().contentEquals("toperson")) {
			if(sd.getCustomername().contentEquals("") || sd.getCustomerphone().contentEquals("") || sd.getCustomerphone().length()<11 || 
					
					sd.getCustomername().length()<1) {
				sd.setCompany("customer name or phone number is wrong");
				return new  ResponseEntity<Sell>(sd,HttpStatus.OK);				
			}
		else {
				memokey=sd.getCustomername()+memokey;
				o.setCustomername(sd.getCustomername());o.setCustomerphone(sd.getCustomerphone());
				o.setMemokey(memokey);
			}
		
			
		}
		
		
		else {
	
			if(sd.getSellshopid()==0 || sd.getSellshopid()<1 ) {
				sd.setCompany("shop id is wrong");
				return new  ResponseEntity<Sell>(sd,HttpStatus.OK);	
			}
				
			   memokey=shopid+memokey;
				o.setSellshopid(sd.getSellshopid());
				o.setCustomername("--");o.setCustomerphone("--");
				o.setMemokey(memokey);	
			
		}
		
	}	
	
	
	if(!record.contentEquals("")){
		
		sd.setCompany(record);
		return new  ResponseEntity<Sell>(sd,HttpStatus.OK);	 	
	}
	
	
	if(sd.getStringselldate().length()<10) {
	
		sd.setCompany("date is wrong , make correction");
return new ResponseEntity<Sell>(sd,HttpStatus.OK);
	
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	   try {
		sd.setSelldate(sdf.parse(sd.getStringselldate()));
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}     
	   
	  	if(sd.getCustomername().length()<1 && sd.getSellto().contentEquals("toperson")) {
		sd.setCompany("customer name is empty");
return new ResponseEntity<Sell>(sd,HttpStatus.OK);	
	}
	
	if(sd.getCustomerphone().length()<11 && sd.getSellto().contentEquals("toperson")) {
		sd.setCompany("customer phone  is wrong");
return new ResponseEntity<Sell>(sd,HttpStatus.OK);	
	}
	
	
	
	if(sd.getSellto().contentEquals("toshopkeeper") && sd.getSellshopid()<1) {
      Optional<Userreg> t = usr.findById((int) sd.getSellshopid());
	if(!t.isPresent()) {
		sd.setCompany("wrong shop id");
return new ResponseEntity<Sell>(sd,HttpStatus.OK);	 
	}
		sd.setCompany("shop id is empty");
return new ResponseEntity<Sell>(sd,HttpStatus.OK);	

	}
	
	
	
for(Sell s : lst) {
s.setStringselldate(sd.getStringselldate());
s.setSelldate(sd.getSelldate());
List<Stock> stl= str.findByShopidAndCompanyAndNameAndCode(shopid,s.getCompany(),s.getName(),s.getCode());
if(stl.isEmpty()) {
	sd.setCompany(s.getName()+", "+s.getCompany()+" this item is not exist ");	
	return new ResponseEntity<Sell>(sd,HttpStatus.OK);	
}

Stock st=stl.get(0);
if(s.getAmount()>st.getAmount()) {
sd.setCompany(s.getName()+", "+s.getCompany()+" this item is not enough in your stock it's amount is "+st.getAmount());
return new ResponseEntity<Sell>(sd,HttpStatus.OK);		
	
}

}


for(Sell s : lst) {
Stock st = str.findByShopidAndCompanyAndNameAndCode(shopid,s.getCompany(),s.getName(),s.getCode()).get(0);
float restamount=st.getAmount()-s.getAmount();
st.setAmount(restamount);
st.setTotalprice(restamount*st.getUnitprice());
str.save(st);	
}

slr.saveAll(lst);
sd.setCompany("successfull");	
return new ResponseEntity<Sell>(sd,HttpStatus.OK);	

}
	

@PostMapping("/filterproduct")
ResponseEntity<List<Makeprice>> filtproduct(@RequestBody Psh psh,HttpSession session){
	
	if(psh.getSby().contentEquals("byname")) {
		List<Makeprice> lst=mpr.findByShopidAndCompanyAndNameContainingIgnoreCase((int) session.getAttribute("shopid"),psh.getCompany(),psh.getName());
		return new ResponseEntity<List<Makeprice>>(lst,HttpStatus.OK);
	}

List<Makeprice> lst=mpr.findByShopidAndCompanyAndCodeContainingIgnoreCase((int) session.getAttribute("shopid"),psh.getCompany(),psh.getCode());
	return new ResponseEntity<List<Makeprice>>(lst,HttpStatus.OK);	
	

}



}
