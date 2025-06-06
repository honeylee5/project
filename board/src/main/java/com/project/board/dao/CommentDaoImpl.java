package com.project.board.dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.project.board.domain.*;

import java.util.*;

@Repository
public class CommentDaoImpl implements CommentDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.project.dao.CommentMapper.";

    @Override
    public int count(Integer bno) throws Exception {
        return session.selectOne(namespace+"count", bno);
    }

    @Override
    public int deleteAll(Integer bno) {
        return session.delete(namespace+"deleteAll", bno);
    }

    @Override
    public int delete(Integer cno, String commenter) throws Exception {
        Map map = new HashMap();
        map.put("cno", cno);
        map.put("commenter", commenter);
        return session.delete(namespace+"delete", map);
    }

    @Override
    public int insert(CommentDto dto) throws Exception {
        return session.insert(namespace+"insert", dto);
    }

    @Override
    public List<CommentDto> selectAll(Integer bno) throws Exception {
        return session.selectList(namespace+"selectAll", bno);
    }

    @Override
    public CommentDto select(Integer cno) throws Exception {
        return session.selectOne(namespace + "select", cno);
    }

    @Override
    public int update(CommentDto dto) throws Exception {
        return session.update(namespace+"update", dto);
    }
}