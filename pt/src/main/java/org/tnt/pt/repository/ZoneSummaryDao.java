package org.tnt.pt.repository;


import java.util.List;
import java.util.Map;

import org.tnt.pt.entity.ZoneSummary;



/**
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * 
 * @author calvin
 */
@MyBatisRepository
public interface ZoneSummaryDao extends BaseDao<ZoneSummary>{
	
	ZoneSummary getZoneSummaryByBusinessIdandZoneGroupId(Map<String,Long> hashMap);
	
	List<ZoneSummary> findAllByBusinessId(Map<String,Object> parameter);
	
	void batchInsert(List<ZoneSummary> zoneSummaryList);
	
	void deleteZoneSummaryList(ZoneSummary zoneSummary);
	
}
