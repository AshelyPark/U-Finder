package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReviewDao;
import model.Review;

public class ReviewUpdate implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int reviewno = Integer.parseInt(request.getParameter("reviewno"));
		int movieno = Integer.parseInt(request.getParameter("movieno"));
		int memberno = Integer.parseInt(request.getParameter("memberno"));
		String content = request.getParameter("content");
		int movielike = Integer.parseInt(request.getParameter("star"));
		
		Review review = new Review();
		review.setReviewno(reviewno);
		review.setMovieno(movieno);
		review.setMemberno(memberno);
		review.setContent(content);
		review.setMovielike(movielike);
		
		// 리뷰dao 연결해서 수정 등록
		ReviewDao rd = ReviewDao.getInstance();
		int result = rd.reviewUpdate(review);
		
		request.setAttribute("result", result);
		request.setAttribute("movieno", movieno);
		
		return "reviewUpdate";
	}

}