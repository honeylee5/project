package com.project.board.controller;

import com.project.board.domain.CommentDto;
import com.project.board.service.CommentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

//@Controller
//@ResponseBody
@RestController // @Controller + @ResponseBody
public class CommentController {
    @Autowired
    CommentService service;

    //    {
//        "pcno":0,
//            "comment" : "hihihi",
//            "commenter" : "honey"
//    }
    // 댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}")   // /board/comments/26  PATCH
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto dto, HttpSession session) {
//        String commenter = (String)session.getAttribute("id");
        String commenter = "honey";
        dto.setCommenter(commenter);
        dto.setCno(cno);
        System.out.println("dto = " + dto);

        try {
            if(service.modify(dto)!=1)
                throw new Exception("Write failed.");

            return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    //    {
//        "pcno":0,
//            "comment" : "hi"
//    }
    // 댓글을 등록하는 메서드
    @PostMapping("/comments")   // /board/comments?bno=1085  POST
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session) { // RequestBody가 있어야 JSON으로 온걸 자바 객체로 넣어준다.
//                          입력한 내용을 받아와야 하므로 CommentDto dto를 받아야함
//        String commenter = (String)session.getAttribute("id");
        String commenter = "honey";
        dto.setCommenter(commenter);
        dto.setBno(bno);
        System.out.println("dto = " + dto);

        try {
            if(service.write(dto)!=1)
                throw new Exception("Write failed.");

            return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}")  // DELETE /comments/1?bno=1085  <-- 삭제할 댓글 번호
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session) {
        //        @PathVariable :  URI 매핑에서 템플릿 변수를 처리 하고 이를 메서드 매개변수로 설정가능 (뒤에 {cno}가 붙으므로)
        //        String commenter = (String)session.getAttribute("id");
        String commenter = "honey";

        try {
            int rowCnt = service.remove(cno, bno, commenter);

            if(rowCnt!=1)
                throw new Exception("Delete Failed");

            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping("/comments")  // /comments?bno=1080   GET
    public ResponseEntity<List<CommentDto>> list(Integer bno) { // 쿼리스트링이 있으므로 PathVariable이 필요없다.
        List<CommentDto> list = null;
        try {
            list = service.getList(bno);
            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK);  // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); // 400
        }
    }


}