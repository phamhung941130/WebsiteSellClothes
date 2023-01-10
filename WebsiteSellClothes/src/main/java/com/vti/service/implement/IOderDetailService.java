package com.vti.service.implement;

import com.vti.entity.OderDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IOderDetailService {


    Page<OderDetail> getOderDetailByOderId(Pageable pageable, int oderId);


    void createOderDetailByOderId(int oderId);
}
