package org.tnt.pt.repository;


import java.util.List;

import org.tnt.pt.entity.HighWeightBand;



/**
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 * 
 * @author calvin
 */
@MyBatisRepository
public interface HighWeightBandDao {

	HighWeightBand get(Long id);

	List<HighWeightBand> findAll();
}
