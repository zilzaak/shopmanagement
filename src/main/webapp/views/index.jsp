<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>my favourite shop</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap431.css" /> " rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap431.js" />" > </script>


<script>
var module=angular.module("sellapp",[]);
module.controller("sellcontrol",function($scope,$http){
	
	$scope.year=[];

	$scope.inityear=function(){
		for(i=2015;i<2040;i++){
			$scope.year.push(i);
		}
			}

$scope.day=["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
$scope.month=["01","02","03","04","05","06","07","08","09","10","11","12"];
	
	

//order1

$scope.products=[];

$scope.check=["1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1",
"1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"];
		

$scope.checkfilt=function(i){
			
		if($scope.check[i]=="0"){
			return true;
		}	
	 	
		if($scope.check[i]=="1"){
			return  false;
		}
		
	                  }
		
		
	
var r=0;

$scope.findproduct=function(i,sby){
	
	if($scope.check[i]=="0"){
		r=i;
		$scope.psh={"name":$scope.order[i].name,"company":$scope.order[i].company,"sby":sby,"code":$scope.order[i].code};
		
		$http({
			method:"POST",
			data:angular.toJson($scope.psh),
			url:"${pageContext.request.contextPath}/product/filterproduct",
	        headers:{"Content-Type":"application/json"}}
			
		).then(function(response){
			
			$scope.products=response.data;
		
		})
	}
			
}


$scope.filltext=function(v){
	$scope.order[r]=v; 
	$scope.order[r].totalprice=v.unitprice*v.amount;
	$scope.check[r]="1";
	$scope.products=[];
	
	
}


$scope.setprice=function(i,v){
	r=i;
	$scope.order[r].totalprice=v.unitprice*v.amount;	
}



$scope.seti=function(i){
	
	if($scope.check[i]=="1"){

		$scope.check[i]="0";

	}
	
else{

		$scope.check[i]="1";

	}
	

}



$scope.orderday=""; $scope.ordermonth=""; $scope.orderyear=""; 
	
    $scope.company=["PRAN","SQUARE","BD FOOD","ACI","ALTRATECH","HOLCIM","BSRM","KSRM","SHAH","LP","TOTAL","JOMUNA","LPG",
    	"ACI","BEXIMCO","SQUARE","RADIANT","OPSONIN","ARISTO PHARMA","DRUG INTERNATIONAL","SQUARE","DELTA","MAGGIE"];
    
	
var o1={"trid":"","company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"",
		"totalprice":"","due":"","stringorderdate":""};  
	
var o2={"trid":"","company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"",
		"totalprice":"","due":"","stringorderdate":""};   
			
var o3={"trid":"","company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"",
		"totalprice":"","due":"","stringorderdate":""};  

$scope.order=[]; 
$scope.order.push(o1,o2,o3);	
	

$scope.addorder=function(i){
var o={"trid":"","company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"",
			"totalprice":"","due":"","stringorderdate":""};  
	$scope.order.splice(i,0,o);
}


$scope.removeorder=function(i){
	if($scope.order.length>1){
		$scope.order.splice(i,1);
	}

}	

$scope.saveorder=function(){
	
	$scope.order[0].stringorderdate=$scope.orderday+"/"+$scope.ordermonth+"/"+$scope.orderyear;
	
	$http({
		
		method:"POST",
		data:angular.toJson($scope.order),
		url:"${pageContext.request.contextPath}/order/saveorder",
        headers:{"Content-Type":"application/json"}}
		
	).then(function(response){
		
	alert(response.data.company);
	
	})
	
	}
	
/*
  
 sell4 section //id="4"
 
 */
 
 $scope.products2=[];
$scope.check2=["1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1",
 "1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"];
 
 $scope.sellday=""; $scope.sellmonth=""; $scope.sellyear=""; 
 
var s1={"company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"","sellto":"",
		"totalprice":"","due":"","stringselldate":"","customername":"","customerphone":"","sellshopid":""};  
	
var s2={"company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"","sellto":"",
		"totalprice":"","due":"","stringselldate":"","customername":"","customerphone":"","sellshopid":""};    
			
var s3={"company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"","sellto":"",
		"totalprice":"","due":"","stringselldate":"","customername":"","customerphone":"","sellshopid":""};  

$scope.sell=[]; 
$scope.sell.push(s1,s2,s3);	
	

$scope.addsell=function(i){
var s={"trid":"","company":"","shopid":"", "name":"","code":"","amount":"","unitprice":"","sellto":"",
			"totalprice":"","due":"","stringselldate":"","sellshopid":""};  
	$scope.sell.splice(i,0,s);
}


$scope.removesell=function(i){
	if($scope.sell.length>1){
		$scope.sell.splice(i,1);
	}

}	


$scope.savesell=function(){
	
if($scope.sell[0].sellto!=""){
		$scope.sell[0].stringselldate=$scope.sellday+"/"+$scope.sellmonth+"/"+$scope.sellyear;
		$http({
			method:"POST",
			data:angular.toJson($scope.sell),
			url:"${pageContext.request.contextPath}/sell/savesell",
	        headers:{"Content-Type":"application/json"}}
			
		).then(function(response){
			
		alert(response.data.company);
		
		})
	}
	if($scope.sell[0].sellto==""){
		alert("select sell to option");
	}
	
	}
	
$scope.sellto=["toperson","toshopkeeper"];
	
	$scope.checkfilt2=function(i){
				
			if($scope.check2[i]=="0"){
				return true;
			}	
		 	
			if($scope.check2[i]=="1"){
				return  false;
			}
			
		                  }
			

	var r2=0;

	$scope.findproduct2=function(i,sby){
		
		if($scope.check2[i]=="0"){
			r2=i;
			$scope.psh={"name":$scope.sell[i].name,"company":$scope.sell[i].company,"sby":sby,"code":$scope.sell[i].code};
			
			$http({
				method:"POST",
				data:angular.toJson($scope.psh),
				url:"${pageContext.request.contextPath}/sell/filterproduct",
		        headers:{"Content-Type":"application/json"}}
				
			).then(function(response){
				
				$scope.products2=response.data;
			
			})
		}
				
	}

	
	$scope.makeprice=[];
	
	$scope.filltext2=function(v){
		$scope.makeprice[r2]=v;
		$scope.sell[r2].code=v.code; $scope.sell[r2].name=v.name;
		$scope.sell[r2].totalprice=v.unitprice*v.amount;
		$scope.sell[r2].unitprice=v.last;
		$scope.check2[r2]="1";
		$scope.products2=[];
		
		
	}


	$scope.setprice2=function(i,v){
		r2=i;
		$scope.sell[r2].totalprice=v.unitprice*v.amount;	
	}
	
	



	$scope.seti2=function(i){
		
		if($scope.check2[i]=="1"){

			$scope.check2[i]="0";

		}
		
	else{

			$scope.check2[i]="1";

		}
		

	}

	$scope.msmvalue=[
"january","february","march","april","may","june","july","august","september","october","november","december"];
	
	//sell5  //masik sell id="5"
	
	$scope.msmonth=""; $scope.msyear="";
	$scope.msarr=[];
	
	$scope.mssell=function(){
	$scope.msarr=[$scope.msmonth,$scope.msyear];
		
	$http({
			method:"POST",
				data:angular.toJson($scope.msarr),
				url:"${pageContext.request.contextPath}/sellquery/sellinamonth",
		        headers:{"Content-Type":"application/json"}}
				
			).then(function(response){
				
			$scope.msr=response.data;
			
			
			})
		}
	
	//sell6 id="6" todays sell
	
	$scope.todayssell=function(){

	$http({
				method:"GET",		
				url:"${pageContext.request.contextPath}/sellquery/todayssell",
			    headers:{"Content-Type":"application/json"}}
					
				).then(function(response){
					
				$scope.tsr=response.data;
				
				
				})
			}	
	
	// masik order id="2"
	
	$scope.momonth=""; $scope.moyear="";
	$scope.moarr=[];
	
	$scope.monthlyorder=function(){
		
	$scope.moarr=[$scope.momonth,$scope.moyear];
		
	$http({
			method:"POST",
				data:angular.toJson($scope.moarr),
				url:"${pageContext.request.contextPath}/odarquery/odarinamonth",
		        headers:{"Content-Type":"application/json"}}
				
			).then(function(response){
				
			$scope.mor=response.data;
			
			
			})
		}
	
	
	//sell6 id="6" todays order id="3"
	$scope.todaysorder=function(){
	$http({
			method:"GET",		
			url:"${pageContext.request.contextPath}/odarquery/todaysodar",
			headers:{"Content-Type":"application/json"}}
					
				).then(function(response){
					
				$scope.tor=response.data;
				
				
				})
			}	
	
	// customer
	
	$scope.customername="";
	$scope.customerphone="";
	$scope.customers=[];
$scope.customerbyname=function(){
		
	$http({
			method:"POST",
			data:angular.toJson($scope.customername),
			url:"${pageContext.request.contextPath}/sell/customerbyname",
		    headers:{"Response-Type":"application/json","Content-Type":"application/json"}}
	).then(function(response){
				
		$scope.customers=response.data;
			
			})
		}
	
$scope.customerbyphone=function(){
	
	$http({
			method:"POST",
			data:angular.toJson($scope.customerphone),
			url:"${pageContext.request.contextPath}/sell/customerbyphone",
			headers:{"Response-Type":"application/json","Content-Type":"application/json"}}
	).then(function(response){
				
		$scope.customers=response.data;
			
			})
		}
		
		

	
//stock
	$scope.pricecatagory=["max","min","last","avg"];
	$scope.selectedprice="";
	
	$scope.getmystock=function(){
	$http({
			method:"POST",
			data:$scope.selectedprice,
			url:"${pageContext.request.contextPath}/stock/getmystock",
	        headers:{"Content-Type":"text/plain","Response-Type":"application/json"}}
			
		).then(function(response){
			
			$scope.mystock=response.data;
			
		})
		
		}
	
	

})






</script>


 <script type="text/javascript">
 
 var arr=[1,2,3,4,5,6,7,8,9,10,11,12,13,14];
 var k=["1","2","3","4","5","6","7","8","9","10","11","12","13","14"];

 function showdiv(i){
	 
 var c=parseFloat(i); 
 
for(var x=0;x<12;x++){
		if(arr[x]==c){
 			
 	document.getElementById(k[x]).style.display="block";
 		
 			}
 		
 	if(arr[x]!=c){
 			
 document.getElementById(k[x]).style.display="none";
 	 						}
 		
 		}
 	
 }
 
 
 
 var ss=["p","q","r","s","t"];
 
 function shos(i,el){
	 	 
	for(var x=0;x<5;x++){
		
		if(ss[x]==i){
			document.getElementById(ss[x]).style.display="block";
		
		}
		if(ss[x]!=i){
			document.getElementById(ss[x]).style.display="none";
	
		}	
		
	}
	
	
	
	
	var chil = document.getElementById("fat").children;
	
	var l=chil.length;
	
	for(var t=0;t<l;t++){

		chil[t].style.background="skyblue";
		
		if(el==chil[t]){
		el.style.background="green";	el.style.color="white";
		
		}


		}
		
	 
 }
 
 
 </script>

<style>


body{
box-sizing:border-box;
background-image:url("/static/theme/sea.jpg");
background-size:1400px 500px;

}


span:hover{
color:red;
background-color:skyblue;
}
table td:hover{
background-color:silver; color:green;

}

input:hover{
background-color:maroon; color:white;

}

table{
overflow-x:scroll;
}

table th{
wrap-word:break-word;
background-color:black;
color:white;
padding:8px;
}

table td{
wrap-word:break-word;
background-color:white;
color:black;
text-align:center;
}

a:hover{
background-color:steelblue;

}


.dropdown-menu a:hover{
background-color:steelblue;

}

</style>

</head>
<body  ng-controller="sellcontrol"  ng-app="sellapp"  ng-init="inityear();" id="mbd">
<%
if(session.getAttribute("adminuser")==null && session.getAttribute("adminpass")==null){
	response.sendRedirect("${pageContext.request.contextPath}"); 
	}

	  %>


<nav class="navbar navbar-expand-lg" style="margin-right:7%;margin-left:8%;margin-top:2%;border-radius:8px;background-color:darkslategrey;">
  <a class="navbar-brand" href="#" style="margin-left:5%;color:maroon;background-color:orange;">দোকানের হিসাব খাতা </a>
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon" style="color:white;"><b>click</b></span>
  </button> 

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          মাল অর্ডার
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#" onclick="showdiv('1');">অর্ডার  Invoice  লিখুন</a> <!-- //order1 -->
          <a class="dropdown-item" href="#" onclick="showdiv('2');">মাসিক অর্ডার দেখুন </a> <!-- //order2 -->
          <a class="dropdown-item" href="#" onclick="showdiv('3');"> আজকের  অর্ডার </a>  <!-- //order3 -->
          <a class="dropdown-item" href="#" onclick="window.open('${pageContext.request.contextPath}/searchorder')">আরও  সার্চ করুন </a>
             </div>
       </li>
    
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          মাল বিক্রি 
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        <a class="dropdown-item" href="#" onclick="showdiv('4');">বিক্রির  INVOICE লিখুন</a> <!-- //sell1 -->
        <a class="dropdown-item" href="#" onclick="showdiv('5');">মাসিক  বিক্রি দেখুন</a> <!-- //sell2 -->
       <a class="dropdown-item" href="#" onclick="showdiv('6');"> আজকের  বিক্রি  </a>  <!-- //sell3 --> 
   <a class="dropdown-item" href="#" onclick="window.open('${pageContext.request.contextPath}/searchsell')">আরও  সার্চ করুন </a>
      
        </div>
       </li>     
      
      
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         কাস্টোমার/ক্রেতা  
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
       <a class="dropdown-item" href="#" onclick="showdiv('7');">কাস্টোমার  খুজুন </a>  <!-- //sell4 --> 
           </div>
       </li>       
      
      
     <li class="nav-item dropdown" style="padding-left:20px;">    <!--   //due1 -->  <!--   //due2 -->
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
         বিক্রির  বকেয়া </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
         <a class="dropdown-item" href="#" onclick="showdiv('10');">মাসিক বকেয়া</a>     
         <a class="dropdown-item" href="#" onclick="showdiv('11');"> আজকের বকেয়া </a>
         <a class="dropdown-item" href="#" onclick="showdiv('13');">যেকোনো তারিখের বকেয়া </a>
         <a class="dropdown-item" href="#" onclick="showdiv('12');">মোট বকেয়া</a>

            </div>
             </li>  
                 <li class="nav-item dropdown" style="padding-left:20px;">  <!-- //stock -->
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button"  onclick="showdiv('8');" 
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        স্টক </a>

     </li> 
     
     
       <li class="nav-item dropdown" style="padding-left:20px;">   <!-- //bank -->
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button"  onclick="showdiv('9');"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
      ব্যাংক </a>       

     </li>   
      
  <li class="nav-item dropdown" style="padding-left:20px;">
      <a class="nav-link" href="#" style="margin-left:5%;color:white;" role="button"  onclick="showdiv('13');"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        ক্যালকুলেটর  </a>

     </li> 
        </ul>
      </div>
</nav>



<!-- calculator -->

<div style="text-align:center;background-color:white;width:85%;display:none;font-size:0.80em;margin-left:8%;" id="14">
 
<style>
 
 .container {
    max-width: 400px;
    margin: 10vh auto 0 auto;
    box-shadow: 0px 0px 43px 17px rgba(153,153,153,1);
}

#display {
    text-align: right;
    height: 70px;
    line-height: 70px;
    padding: 8px;
    font-size: 25px;
}

.buttons {
    display: grid;
    border-bottom: 1px solid #999;
    border-left: 1px solid#999;
    grid-template-columns: 1fr 1fr 1fr 1fr;
}

.buttons > div {
    border-top: 1px solid #999;
    border-right: 1px solid#999;
}

.button {
    border: 0.5px solid #999;
    line-height: 50px;
    text-align: center;
    font-size: 25px;
    cursor: pointer;
}

#equal {
    background-color: rgb(85, 85, 255);
    color: white;
}

.button:hover {
    background-color: #323330;
    color: white;
    transition: 0.5s ease-in-out;
}
 
 </style>
 
<h4 style="color:white;">মাল এর  অর্ডার   লিখুন</h4>
 <div class="container">
            <div id="display"></div>
            <div class="buttons">
                <div class="button">C</div>
                <div class="button">/</div>
                <div class="button">*</div>
                <div class="button">&larr;</div>
                <div class="button">7</div>
                <div class="button">8</div>
                <div class="button">9</div>
                <div class="button">-</div>
                <div class="button">4</div>
                <div class="button">5</div>
                <div class="button">6</div>
                <div class="button">+</div>
                <div class="button">1</div>
                <div class="button">2</div>
                <div class="button">3</div>
                <div class="button">.</div>
                <div class="button">(</div>
                <div class="button">0</div>
                <div class="button">)</div>
                <div id="equal" class="button">=</div>
            </div>
        </div>
        
        <script type="text/javascript">
        var display = document.getElementById('display');

        var buttons = Array.from(document.getElementsByClassName('button'));

        buttons.map( button => {
            button.addEventListener('click', (e) => {
                switch(e.target.innerText){
                    case 'C':
                        display.innerText = '';
                        break;
                    case '=':
                        try{
                            display.innerText = eval(display.innerText);
                        } catch {
                            display.innerText = "Error"
                        }
                        break;
                    case '←':
                        if (display.innerText){
                           display.innerText = display.innerText.slice(0, -1);
                        }
                        break;
                    default:
                        display.innerText += e.target.innerText;
                }
            });
        });

        
        </script>
<br/>
<br/>

</div>
 
 
 
 <!--  //order1 -->
 

 <div  style="text-align:center;background-color:darkseagreen;width:85%;display:none;font-size:0.80em;margin-left:8%;" id="1">
<h4 style="color:white;">অর্ডার  INVOICE লিখুন</h4>
<br/><br/>

<span><b>Date:-</b>
day:<select ng-options="c for c in day" ng-model="orderday"></select>
month:<select  ng-options="c for c in month" ng-model="ordermonth" ></select>
year:<select  ng-options="c for c in year" ng-model="orderyear" ></select>
</span> <br/>

<br/>
<b>Bank transaction id:-</b> <input type="text" ng-model="order[0].trid" /> <br/>
 <br/>
		
<table border="1" align="center" > 
<tr>
<th>index</th>
<th>
company
<br/>
product name
</th>

<th>product code</th>
<th>amount</th>
<th>unit price</th>
<th>total price</th>
<th>task</th>
</tr>
<tr  ng-repeat="x in order">
<td>{{$index+1}}</td>
<td>
<b>company:</b> <br/> <select ng-options="c for c in company"  ng-model="x.company" style="width:100px;"></select>
<br/>
<b>product name:-</b> <br/>
<input type="text"  ng-model="x.name"  ng-keyup="findproduct($index,'byname')"  ng-click="seti($index)"/>
<ul class="list-group" ng-if="checkfilt($index)">
<li class="list-group-item" ng-repeat="k in products" ng-click="filltext(k)">{{k.code}} {{k.name}}
</li>
</ul>


</td>
<td><input type="text"  ng-model="x.code"  ng-keyup="findproduct($index,'bycode')"  ng-click="seti($index)" />
<ul class="list-group" ng-if="checkfilt($index)">
<li class="list-group-item" ng-repeat="k in products" ng-click="filltext(k)">{{k.code}} {{k.name}}
</li>
</ul>
</td>

<td><input type="number"  ng-model="x.amount" ng-keyup="setprice($index,x)" />

</td>
<td><input type="number"  ng-model="x.unitprice" ng-keyup="setprice($index,x)"  />
</td>
<td><input type="number"  ng-model="x.totalprice" /></td>
<td><button class="btn btn-primary btn-sm" ng-click="addorder($index)">(+)</button> <br/> <br/>
<button class="btn btn-primary btn-sm" ng-click="removeorder($index)">(-)</button></td>

</tr>

</table>
<br/>
<button class="btn btn-success btn-sm" ng-click="saveorder()" >submit</button>
<br/>
<br/>
<br/>

</div>



//id="3" 
 <!--  //order3 -->
<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="3">
<h4>আজকের মোট অর্ডার   ==id=3</h4>
<button ng-click="todaysorder()">todays order</button> <br/>

<table align="center" border="1" ng-if="tor.odars.length>0">
 <tr>
 <th>
 product <br/>
 information
 </th>
 <th>
 amount <br/>
 & taka
 </th>
 <th>
 sell date
 </th>
 </tr>
 
 <tr ng-repeat="x in tor.odars">
 <td>
 name:{{x.name}} <br/>
 company:{{x.company}} <br/>
 code:{{x.code}}<br/>
 unit price:{{x.unitprice}}<br/>

 
 </td>
 

 <td>
 amount:{{x.amount}}<br/>
 totalprice:{{x.totalprice}}<br/>
  unit price:{{x.unitprice}}<br/>
 </td>
 <td>
 date:{{x.stringorderdate}}
 </td>
 </tr>
 </table>
</div>


 <!--  //order3 -->
<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="2">
<h4>মাসিক  অর্ডার দেখুন  id=2</h4>
 <h4 style="text-align:center;color:white;">মাসিক  odar  হিসাব   </h4>
  
  month::<select ng-options="c for c in msmvalue" ng-model="momonth"></select> <br/> 
  
  year::<select ng-options="c for c in year" ng-model="moyear"></select>
  <br/> <br/>
  <button ng-click="monthlyorder()" class="btn btn-sm btn-success">click</button>
  <br/>
  
 <h4 ng-if="mor!=null">total sell : {{mor.totalodar}}tk </h4> 
 <br/>
 <table align="center" border="1" ng-if="mor.odars.length>0">
 <tr>
 <th>
 product <br/>
 information
 </th>
 <th>
 amount <br/>
 & taka
 </th>
 <th>
 sell date
 </th>
 </tr>
 
 <tr ng-repeat="x in mor.odars">
 <td>
 name:{{x.name}} <br/>
 company:{{x.company}} <br/>
 code:{{x.code}}<br/>
 unit price:{{x.unitprice}}<br/>

 
 </td>
 

 <td>
 amount:{{x.amount}}<br/>
 totalprice:{{x.totalprice}}<br/>
  unit price:{{x.unitprice}}<br/>
 </td>
 <td>
 date:{{x.stringorderdate}}
 </td>
 </tr>
 </table>

</div>


<!-- -//sell1 -->
<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="4">

<h4 style="color:white;">বিক্রির  Invoice লিখুন  id="4"</h4>
<br/><br/>

<span><b>Date:-</b>
day:<select ng-options="c for c in day" ng-model="sellday"></select>
month:<select  ng-options="c for c in month" ng-model="sellmonth" ></select>
year:<select  ng-options="c for c in year" ng-model="sellyear" ></select>
</span> <br/>

<br/>
<b>sell to:-</b><select ng-options="c for c in sellto" ng-model="sell[0].sellto" ng-change="selectcustomer()"></select>
<br/>
<div ng-if="sell[0].sellto=='toperson'">
customer name: <input ng-model="sell[0].customername" /> <br/>
customer phone: <input ng-model="sell[0].customerphone" > <br/>
</div>

<div ng-if="sell[0].sellto=='toshopkeeper'">
shop id: <input type="number" ng-model="sell[0].sellsshopid"> <br/>
</div>

<table border="1" align="center" > 
<tr>
<th>index</th>
<th>
company
<br/>
product name
</th>

<th>product code</th>
<th>amount</th>
<th>unit price</th>
<th>total price</th>
<th>task</th>
</tr>
<tr  ng-repeat="x in sell">
<td>{{$index+1}}</td>
<td>
<b>company:</b> <br/> <select ng-options="c for c in company"  ng-model="x.company" style="width:100px;"></select>
<br/>
<b>product name:-</b> <br/>
<input type="text"  ng-model="x.name"  ng-keyup="findproduct2($index,'byname')"  ng-click="seti2($index)"/>
<ul class="list-group" ng-if="checkfilt2($index)">
<li class="list-group-item" ng-repeat="k in products2" ng-click="filltext2(k)">{{k.code}} {{k.name}}
</li>
</ul>

</td>

<td><input type="text"  ng-model="x.code"  ng-keyup="findproduct2($index,'bycode')"  ng-click="seti2($index)" />
<ul class="list-group" ng-if="checkfilt2($index)">
<li class="list-group-item" ng-repeat="k in products" ng-click="filltext2(k)">{{k.code}} {{k.name}}
</li>
</ul>

</td>

<td><input type="number"  ng-model="x.amount" ng-keyup="setprice2($index,x)" /></td>
<td><input type="number"  ng-model="x.unitprice" ng-keyup="setprice2($index,x)"  />
<div ng-if="makeprice[$index]!=null">
<b style="color:green;">last price:{{makeprice[$index].last}}</b> <br/>
<b style="color:green;">avg price:{{makeprice[$index].avg}}</b> <br/>
<b style="color:green;">max price:{{makeprice[$index].max}}</b> <br/>
<b style="color:green;">min price:{{makeprice[$index].min}}</b> <br/>
</div>
</td>
<td><input type="number"  ng-model="x.totalprice" /></td>
<td><button class="btn btn-primary btn-sm" ng-click="addsell($index)">(+)</button> <br/> <br/>
<button class="btn btn-primary btn-sm" ng-click="removesell($index)">(-)</button></td>

</tr>
</table>
<br/>
<button class="btn btn-success btn-sm" ng-click="savesell()" >submit</button>
<br/>
<br/>
<br/>

</div>


<!-- -//sell2 id="5"-->
<div  style="margin-left:8%;text-align:center;background-color:burlywood;width:85%;display:none;font-size:0.80em;" id="5">

  <h4 style="text-align:center;color:white;">মাসিক  বিক্রি হিসাব   </h4>
  
  month::<select ng-options="c for c in msmvalue" ng-model="msmonth"></select> <br/> 
  
  year::<select ng-options="c for c in year" ng-model="msyear"></select>
  <br/> <br/>
  <button ng-click="mssell()" class="btn btn-sm btn-success">sell now</button>
  <br/>
  
 <h4 ng-if="msr!=null">total sell : {{msr.totalsell}}tk  total due :  {{msr.totaldue}}</h4> 
 <br/>
 <table align="center" border="1" ng-if="msr.sells.length>0">
 <tr>
 <th>
 product <br/>
 information
 </th>
 <th>
 Shop id <br/>
 or customer
 </th>
 <th>
 amount <br/>
 & taka
 </th>
 <th>
 sell date
 </th>
 </tr>
 
 <tr ng-repeat="x in msr.sells">
 <td>
 name:{{x.name}} <br/>
 company:{{x.company}} <br/>
 code:{{x.code}}<br/>
 unit price:{{x.unitprice}}<br/>

 
 </td>
 
  <td>
  <div ng-if="x.sellto=='toperson'">
   customer name:{{x.customername}}<br/>
   phone:{{x.customerphone}}<br/>
   
  </div>
  
<div ng-if="x.sellto=='toshopkeeper'">
  shop id:{{x.sellshopid}} <br/>
  </div>
  
 </td>
 <td>
 amount:{{x.amount}}<br/>
 totalprice:{{x.totalprice}}<br/>
  unit price:{{x.unitprice}}<br/>
 </td>
 <td>
 date: {{x.stringselldate}}
 </td>
 </tr>
 </table>

</div>


<!-- -//sell3 -->
<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="6">
<h4>আজকের  মোট বিক্রি id=6</h4>
 <br/><br/>
  <button ng-click="todayssell()" class="btn btn-sm btn-success">sell now</button>
  <br/>
 
 <h4 ng-if="tsr!=null">total sell : {{tsr.totalsell}}tk  total due :  {{tsr.totaldue}}</h4> 
 <br/>
 <table align="center" border="1" ng-if="tsr.sells.length>0">
 <tr>
 <th>
 product <br/>
 information
 </th>
 <th>
 Shop id <br/>
 or customer
 </th>
 <th>
 amount <br/>
 & taka
 </th>
 <th>
 sell date
 </th>
 </tr>
 
 <tr ng-repeat="x in tsr.sells">
 <td>
 name:{{x.name}} <br/>
 company:{{x.company}} <br/>
 code:{{x.code}}<br/>
 unit price:{{x.unitprice}}<br/>

 
 </td>
 
  <td>
  <div ng-if="x.sellto=='toperson'">
   customer name:{{x.customername}}<br/>
   phone:{{x.customerphone}}<br/>
   
  </div>
  
<div ng-if="x.sellto=='toshopkeeper'">
  shop id:{{x.sellhopid}} <br/>
  </div>
  
 </td>
 <td>
 amount:{{x.amount}}<br/>
 totalprice:{{x.totalprice}}<br/>
  unit price:{{x.unitprice}}<br/>
 </td>
 <td>
 date: {{x.stringselldate}}
 </td>
 </tr>
 </table>

</div>

<!-- //sellY -->

<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="7">
<h4>search customer</h4><br/>
<input type="text" ng-model="customername" ng-keyup="customerbyname()" /> <br/>
<input type="text" ng-model="customerphone" ng-keyup="customerbyphone()" /> <br/>

<table border="1" align="center">
<tr>
<th>customer name</th>
<th>shop id</th>
<th>customer phone</th>
<th>product name</th>
<th>company</th>
<th>selling date</th>
</tr>

<tr ng-repeat="x in customers">
<th>{{x.customername}}</th>
<th>{{x.sellsshopid}}</th>
<th>{{x.customerphone}}</th>
<th>{{x.name}}</th>
<th>{{x.company}}</th>
<th>{{x.stringselldate}}</th>
</tr>
</table>

</div>




<!-- //stock -->
<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="8">

select price of each product to find totalstock:<select ng-model="selectedprice" ng-options="c for c in pricecatagory"></select><br/>
<button ng-click="getmystock()">get stock</button>
<br/>

<h4>total price of products : {{mystock.totaltaka}}</h4>
<br/>
<table align="center" border="1">
<tr>
<th>company</th>
<th>product name</th>
<th>product code</th>
<th>unit price</th>
<th>amount</th>
<th>total price</th>
</tr>

<tr ng-repeat="x in mystock.sts">
<td>{{x.company}}</td>
<td>{{x.name}}</td>
<td>{{x.code}}</td>
<td>{{x.unitprice}}</td>
<td>{{x.amount}}</td>
<td>{{x.totalprice}}</td>
</tr>

</table>

</div>



<!-- //bank -->
<div  style="margin-left:8%;background-color:skyblue;width:85%;display:none;font-size:0.80em;padding:20px;text-align:center;" id="9">
<h4>ব্যাংক   স্টক </h4>

</div>


<!-- //due1  monthly due-->
<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="10">

<h>id="10" </h>


</div>


<!-- //due2  todays due -->

<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="11">

<h>id="11"</h>

</div>


<!-- //due3  total due-->
<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="12">
<h>id="12"</h>

</div>

<!-- //due3  any date-->
<div  style="text-align:center;margin-left:8%;background-color:gray;width:85%;display:none;font-size:0.80em;padding:20px" id="13">
<h>id="13"</h>

</div>


</body>

</html>
