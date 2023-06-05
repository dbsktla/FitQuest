package product.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductDao {
	private final String namespace = "product.model.Product";
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	public List<ProductBean> getProductListById(String id) {
		List<ProductBean> pList = new ArrayList<ProductBean>();
		pList = sqlSessionTemplate.selectList(namespace + ".GetProductListById", id);
		return pList;
	}
}
