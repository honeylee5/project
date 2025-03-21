package com.project.board.dao;

import org.apache.ibatis.session.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.project.board.domain.*;

import java.util.*;

@Repository
public class BoardDaoImpl implements BoardDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.project.dao.BoardMapper.";

    public int count() throws Exception {
        return session.selectOne(namespace+"count");
    } // T selectOne(String statement)

    @Override
    public int deleteAll() {
        return session.delete(namespace+"deleteAll");
    } // int delete(String statement)

    @Override
    public int delete(Integer bno, String writer) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("writer", writer);
        return session.delete(namespace+"delete", map);
    } // int delete(String statement, Object parameter)

    public int insert(BoardDto dto) throws Exception {
        return session.insert(namespace+"insert", dto);
    } // int insert(String statement, Object parameter)

    @Override
    public List<BoardDto> selectAll() throws Exception { // 게시물 리스트 보여주기
        return session.selectList(namespace+"selectAll");
    } // List<E> selectList(String statement)

    public BoardDto select(Integer bno) throws Exception {
        return session.selectOne(namespace + "select", bno);
    } // T selectOne(String statement, Object parameter)

    @Override
    public List<BoardDto> selectPage(Map map) throws Exception {  // map을 받아서
        return session.selectList(namespace+"selectPage", map); // 그 값을 boardMapper.xml로 넘겨준다
    } // List<E> selectList(String statement, Object parameter)

    @Override
    public int update(BoardDto dto) throws Exception {
        return session.update(namespace+"update", dto);
    } // int update(String statement, Object parameter)

    @Override
    public int increaseViewCnt(Integer bno) throws Exception {
        return session.update(namespace+"increaseViewCnt", bno);
    } // int update(String statement, Object parameter)

    @Override
    public int searchResultCnt(SearchCondition sc) throws Exception { // 검색결과 갯수(이걸 알아야 페이징 가능)
        System.out.println("sc in searchResultCnt() = " + sc);
        System.out.println("session = " + session);
        return session.selectOne(namespace+"searchResultCnt", sc);
    } // T selectOne(String statement, Object parameter)

    @Override
    public int updateCommentCnt(Integer bno, int cnt) {
        Map map = new HashMap();
        map.put("cnt", cnt);
        map.put("bno", bno);
        return session.selectOne(namespace+"updateCommentCnt", map);
    }

    @Override
    public List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception {
        return session.selectList(namespace+"searchSelectPage", sc);
    } // List<E> selectList(String statement, Object parameter)
}