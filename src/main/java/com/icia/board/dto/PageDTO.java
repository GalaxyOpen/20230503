package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class PageDTO {
    private int page; // 현재 페이지
    private int maxPage; // 전체 페이지 갯수
    private int startPage; // 하단에 보여지는 시작페이지
    private int endPage; // 하단에 보여지는 마지막 페이지 번호
    }
