package picka.data.dao;

import org.springframework.data.annotation.Id;

public class Review {

	@Id
	String userId; // 후기를 작성한 유저 아이디
	String review; // 작성된 후기
	int point; // 평점

	public Review() {
		super();
	}

	public Review(String userId, String review, int point) {
		super();
		this.userId = userId;
		this.review = review;
		this.point = point;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}

	@Override
	public String toString() {
		
		StringBuilder builder = new StringBuilder();
		builder.append("Review [userId=")
				.append(userId)
				.append(", review=")
				.append(review)
				.append(", point=")
				.append(point)
				.append("]");
		return builder.toString();
		
	}

}
