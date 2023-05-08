package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.CommentDTO;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/comment")

public class CommentController {
    @Autowired
    private CommentService commentService;

    @PostMapping("/save")
    public ResponseEntity save(@ModelAttribute CommentDTO commentDTO){
        System.out.println("commentDTO = " + commentDTO);
        commentService.save(commentDTO);
        List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
        // 이 게시글에 작성된 댓글만 가져와야 한다. 그래서
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }


}
