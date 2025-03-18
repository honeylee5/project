package com.project.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.board.dao.JoinDao;
import com.project.board.domain.User;

@Service
public class JoinServiceImpl implements JoinService {
	@Autowired
    JoinDao joinDao;

    @Override
    public int join(User user) throws Exception {
        return joinDao.join(user);
    }
}