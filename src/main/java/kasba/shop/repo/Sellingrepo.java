package kasba.shop.repo;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import kasba.shop.helper.Masiksell;
import kasba.shop.model.Sell;
public interface Sellingrepo extends JpaRepository<Sell,Integer>{

	List <Sell> findBySelldateBetween(Date d, Date d2);

	List<Sell> findBySelldate(Date d);

	List<Sell> findByCustomernameContainingIgnoreCase(String asik);

	List<Sell> findByCustomerphoneContainingIgnoreCase(String asik);
	
    @Query("SELECT DISTINCT p.memokey  FROM Sell p WHERE p.customername like %:customername%")
    public List<Sell> distinctname(String customername);
	
    @Query("SELECT DISTINCT p.memokey  FROM Sell p WHERE p.customerphone like %:customerphone%")
    public List<Sell> distinctphone(String customerphone);
}
