package org.tnt.pt.web.baseInfo;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springside.modules.mapper.JsonMapper;
import org.tnt.pt.entity.Product;
import org.tnt.pt.entity.Tariff;
import org.tnt.pt.entity.TariffGroup;
import org.tnt.pt.entity.ZoneGroup;
import org.tnt.pt.entity.ZoneType;
import org.tnt.pt.service.baseInfo.ProductService;
import org.tnt.pt.service.baseInfo.TariffGroupService;
import org.tnt.pt.service.baseInfo.TariffService;
import org.tnt.pt.service.baseInfo.WeightBandService;
import org.tnt.pt.service.baseInfo.ZoneGroupService;
import org.tnt.pt.service.baseInfo.ZoneTypeService;
import org.tnt.pt.util.PTPARAMETERS;
import org.tnt.pt.vo.JsonData;



/**
 * ProductController负责产品的请求，
 * 
 * @author yuanchen
 */
@Controller
@RequestMapping(value = "/traiff")
public class TraiffController {
    @Autowired
	ZoneGroupService zonegroupService;
    @Autowired
	ZoneTypeService zoneTypeService;
    @Autowired
	ProductService productService;
    @Autowired
	TariffService tariffService;
    @Autowired
   	TariffGroupService tariffGroupService;
    @Autowired
    WeightBandService weightBandService;
    
    /**
	 * 产品_时区_折扣  详细页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="init")
	public String init(Model model) {
		/**
		 * 该处为zonetypeList获取代码
		 */
		List<ZoneGroup> zoneGroupList = new ArrayList<ZoneGroup>();
		List<Product> productList = new ArrayList<Product>();
		//List<WeightBand> weightBandList = new ArrayList<WeightBand>();
		List<ZoneType> zoneTypeList = new ArrayList<ZoneType>();
		List<Tariff> tariffList = new ArrayList<Tariff>();
		Map<String,Double> traiffMap = new HashMap<String,Double>();//形成折扣map 方便查询
		List<TariffGroup> tariffGroupList= new ArrayList<TariffGroup>();
		/**
		 * 假如zonetype不为空，则默认初始加载的为第一个zonetype
		 */
		zoneTypeList =  zoneTypeService.getAllZoneType();
		if(zoneTypeList.size()>0){
			ZoneType zoneType = zoneTypeList.get(0);
			zoneGroupList =  zonegroupService.getAllZoneGroupByZoneType(zoneType.getZoneType());
			productList.add(productService.getProduct(zoneType.getDocument()));
			productList.add(productService.getProduct(zoneType.getNonDocument()));
			productList.add(productService.getProduct(zoneType.getEconomy()));
			//weightBandList = weightBandService.getAllWeightBandByProductId(zoneType.getDocument());
			tariffGroupList = tariffGroupService.getAllTariffGroup(zoneType.getDocument(),PTPARAMETERS.PAYMENT[1]);
		}
		
		tariffList = tariffService.getAllTariff();
		for (Tariff tariff:tariffList) {
			traiffMap.put(tariff.getTariffGroupId()+"_"+tariff.getZoneGroupId(), tariff.getTariff());
		}
		
		model.addAttribute("zoneGroupList", zoneGroupList);
		model.addAttribute("productList", productList);
		model.addAttribute("zoneTypeList", zoneTypeList);
		model.addAttribute("tariffGroupList", tariffGroupList);
		model.addAttribute("traiffMap", traiffMap);
		
		return "discountRate/fullTariffMaintenance";
	}
	
	/**
	 * 产品_时区_折扣  详细页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="query")
	public String query(@RequestParam(value = "productId", required = false) Long productId,
			@RequestParam(value = "zoneTypeId", required = false) Long zoneTypeId,
			@RequestParam(value = "payment", required = false) String payment,Model model) {
		
		
		List<ZoneGroup> zoneGroupList = new ArrayList<ZoneGroup>();
		List<Product> productList = new ArrayList<Product>();
		//List<WeightBand> weightBandList = new ArrayList<WeightBand>();
		List<ZoneType> zoneTypeList = new ArrayList<ZoneType>();
		List<Tariff> tariffList = new ArrayList<Tariff>();
		List<TariffGroup> tariffGroupList = new ArrayList<TariffGroup>();
		Map<String,Double> traiffMap = new HashMap<String,Double>();//形成折扣map 方便查询
		
		ZoneType zoneType = zoneTypeService.getZoneTypeById(zoneTypeId);
		//weightBandList = weightBandService.getAllWeightBandByProductId(productId);
		tariffGroupList = tariffGroupService.getAllTariffGroup(productId,payment);
		
		/**
		 * 获取产品与zonegroup集合
		 */
		zoneGroupList =  zonegroupService.getAllZoneGroupByZoneType(zoneType.getZoneType());
		productList.add(productService.getProduct(zoneType.getDocument()));
		productList.add(productService.getProduct(zoneType.getNonDocument()));
		productList.add(productService.getProduct(zoneType.getEconomy()));
		
		/**
		 * 获取默认价格map
		 */
		tariffList = tariffService.getAllTariff();
		for (Tariff tariff:tariffList) {
			traiffMap.put(tariff.getTariffGroupId()+"_"+tariff.getZoneGroupId(), tariff.getTariff());
		}
		
		
		zoneTypeList =  zoneTypeService.getAllZoneType();
		
		model.addAttribute("zoneGroupList", zoneGroupList);
		model.addAttribute("productList", productList);
		model.addAttribute("zoneTypeList", zoneTypeList);
		//model.addAttribute("weightBandList", weightBandList);
		model.addAttribute("tariffGroupList", tariffGroupList);
		model.addAttribute("traiffMap", traiffMap);
		model.addAttribute("productId", productId);
		model.addAttribute("zoneTypeId", zoneTypeId);
		model.addAttribute("payment", payment);
		return "discountRate/fullTariffMaintenance";
	}
	
	
	@RequestMapping(value="add", method = {RequestMethod.POST })
	@ResponseBody 
	public String addTariff(@RequestBody String jsonDatas) {
		String msg = "";
		List<JsonData> jsonDataList = new ArrayList<JsonData>();
		//List<DiscountDefault>  discountDefaultList = new ArrayList<DiscountDefault>();
		//List<Tariff>  tariffList = new ArrayList<Tariff>();
		try {
			JSONArray array = new JSONArray(jsonDatas); 
			for(int i = 0; i < array.length(); i++) {  
				JsonData jsonData = JsonMapper.nonDefaultMapper().fromJson(array.getString(i), JsonData.class);  
                jsonDataList.add(jsonData);  
            }  
		} catch (ParseException e) {
			msg = e.getMessage();
		}
		for (JsonData jsonData:jsonDataList) {
			String name = jsonData.getName();
			String[] discountArr = name.split("_");
			Tariff tariff = new Tariff();
			tariff.setTariffGroupId(Long.valueOf(discountArr[1]));
			tariff.setZoneGroupId(Long.valueOf(discountArr[2]));
			String value = jsonData.getValue();
			tariff.setTariff(Double.valueOf((value==null||"".equals(value))?"0":value));
			tariffService.add(tariff);
		}
		return msg;
	}
	
	    /**
		 * 导入tariff
		 *@param model
		 * @return
		 */
		 @RequestMapping(value="upload",method = RequestMethod.POST)
		 public String upload(@RequestParam("myFile") CommonsMultipartFile file,HttpServletRequest request,Model model){
			 try {
					Map<String,String> tariffMap= new HashMap<String,String>();//初始化tariffMap
					String errmsg = null;
					String[] sheets = new String[]{"15D-SP","15D-RP","15N-SP","15N-RP","48N-SP","48N-RP"};//默认sheet //,"15D-RP","15N-SP","15N-RP","48N-SP","48N-RP"
					String[] zoneGroups = new String[]{"ZONE1","ZONE2","ZONE3","ZONE4","ZONE5","ZONE6","ZONE7","ZONE8","ZONE9","ZONE10","ZONE11"};//默认sheet
					String myFilePath = file.getFileItem().getName();
			        int index = myFilePath.lastIndexOf("."); //取得文件名中最后一个"."的索引
			        String newext = myFilePath.substring(index); //获取文件扩展名
			        
			        if (newext.equalsIgnoreCase(".xls")) {
						// 开始读取excel
						// 创建对Excel工作簿文件的引用
						HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
						for (int k = 0; k < sheets.length; k++) {
							Map<Double,Long> tgMap = new HashMap<Double,Long>();
							Map<String,Long> zgMap = new HashMap<String,Long>();
							List<TariffGroup> tgs = new ArrayList<TariffGroup>();
							List<ZoneGroup> zgs = new ArrayList<ZoneGroup>();
							
							Long productId = 0l;
							String payment = "";
							if(sheets[k].contains("15D")){
								productId = 1l;//写死
							}else if(sheets[k].contains("15N")){
								productId = 2l;
							}else{
								productId = 3l;
							}
							if(sheets[k].contains("SP")){
								payment = "SenderPay";
							}else{
								payment = "ReceivePay";
							}
							//装配Tariffgroup
							tgs = tariffGroupService.getAllTariffGroup(productId, payment);
							for(TariffGroup tg:tgs){
								tgMap.put(tg.getWeight(), tg.getId());
							}
							//装配zonegroup
							zgs =  zonegroupService.getAllZoneGroupByZoneType("11ZONE");
							for(ZoneGroup zg:zgs){
								zgMap.put(zg.getZone(), zg.getId());
							}
							
							HSSFSheet sheet = workbook.getSheet(sheets[k]);//获取第几个sheet
							HSSFRow row = null;
							int rows = sheet.getLastRowNum();
							//从第二行第一列开始读取
							for (int i = 1; i <= rows; i++) {
								row = sheet.getRow(i);
								Double cell0 = Double.valueOf(getCell(row.getCell(0)));//获取cell的值
								for (int cellNum = 1; cellNum < row.getLastCellNum(); cellNum++) { 
									 String cellValue = getCell(row.getCell(cellNum));//获取cell的值
									 tariffMap.put(tgMap.get(cell0)+"_"+zgMap.get(zoneGroups[cellNum-1]), cellValue);
								}
							}
						}
				        for (Iterator it = tariffMap.keySet().iterator(); it.hasNext();) {
				        	Tariff tf = new Tariff();
				            String key = (String) it.next();
				            String[] keys = key.split("_");
				            String value = tariffMap.get(key);
				            
				            tf.setTariff(Double.valueOf(value));
				            tf.setTariffGroupId(Long.valueOf(keys[0]));
				            tf.setZoneGroupId(Long.valueOf(keys[1]));
				            tariffService.add(tf);
				        }
				        
			        }else{
			        	errmsg = "请使用xls格式的文件";
			        	model.addAttribute("errmsg",errmsg);
			        	return "discountRate/fullTariffMaintenance"; 
			        }
				} catch (IOException e) {
					e.printStackTrace();
				}
			return "redirect:/traiff/init";
		 }
		 
		 public  String getCell(HSSFCell cell) {
				if (cell == null)
					return "";
				switch (cell.getCellType()) {
				case HSSFCell.CELL_TYPE_NUMERIC:    
						return cell.getNumericCellValue() + "";
				case HSSFCell.CELL_TYPE_STRING:
					return cell.getStringCellValue();
				case HSSFCell.CELL_TYPE_FORMULA:
					return cell.getCellFormula();
				case HSSFCell.CELL_TYPE_BLANK:
					return "";
				case HSSFCell.CELL_TYPE_BOOLEAN:
					return cell.getBooleanCellValue() + "";
				case HSSFCell.CELL_TYPE_ERROR:
					return cell.getErrorCellValue() + "";
				}

				return "";
		}
}
