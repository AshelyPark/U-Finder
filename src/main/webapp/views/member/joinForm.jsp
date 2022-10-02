<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  
<style type="text/css">

.check input {
	width: 85%;
}

fieldset {
	width: 400px;
}

.ott-select legend {
	color: white;
}

input[type=checkbox] {
	width: 10px;
}


</style>

<link rel="stylesheet" type="text/css" href="../../css/member.css">

<script type="text/javascript">

/* 아이디 중복체크 */
function chkId() {
	/* 이메일 유효성 검사 */
		// 문장의 맨앞과 끝의 /는 이 식이 정규식임을 의미
		// 문장의 처음은 ^, 끝은 $
		// [0-9a-zA-Z_-]+ : 숫자 또는 영문자 또는 _ 또는 -이 1개이상(+)이상 
		// \. : . 이 들어감
	var reg_id = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	var isIdChecked = 'Y';
	
//id 값이 없을때
	if (!frm.id.value) {
		alert("이메일을 입력하세요")
		frm.id.focus();

		//id 값이 있을떄
	} else {
		if (!reg_id.test(frm.id.value)) { //아이디 유효성검사 통과 못했을떄
			alert("올바른 이메일 형식이 아닙니다.");
			frm.id.focus();
			return false;
			//아이디 유효성검사 통과했을떄
		} else {
			/* 아이디 중복확인 */
			// jQuery Ajax이용하는 방법. data는 confirmId.do를 실행한 결과
			// 아이디가 err_id인 곳에 data를 html 형식으로 넣어라  
			$.post("/project_semi/views/member/confirmId.do", "id="
					+ frm.id.value, function(data) {
				$('#err_id').html(data);
			});
		}
	}
	return false;
}

/* 	비밀번호 6자리 이상 제한 */
function chkPass() {
	var pw = $("#password").val();
	if (pw.length < 6) {
		$('#err_pass').html("6자리 이상 입력해주세요");
		frm.password.focus();
		frm.password.value = "";
		return false;
	} else {
		$('#err_pass').html("사용가능한 비밀번호입니다");
	}
}

/* 비밀번호&확인 일치여부 체크 */
function chkPassword() {
	if (frm.password.value != frm.confirmPassword.value) {
		alert("비밀번호가 일치하지 않습니다")
		frm.password.focus();
		frm.password.value = "";
		frm.confirmPassworsd.value = "";
		return false;
	}
}

/* 닉네임 중복체크 */
function chkNick() {
	var isNickChecked = 'Y';
	if (!frm.nickname.value) {
		alert("별명을 입력하세요")
		frm.nickname.focus();
	} else {
		$.post("/project_semi/views/member/confirmNick_nm.do", "nickname="
				+ frm.nickname.value, function(data) {
			$('#err_nm').html(data);
		});
	}
	return false;
}

/* 아이디, 닉네임 중복체크 버튼 눌렀는지 더블체크 */
	
	function doublechk() {

		if (isIdchecked != 'Y') {
			alert("아이디 중복체크 버튼을 눌러주세요")
			return false;
		}
		if (isNickChecked != 'Y') {
			alert("닉네임 중복체크 버튼을 눌러주세요")
			return false;
		}

	}
</script>

</head>
<body>

	<div class="container" >
	<form action="/project_semi/views/member/joinResult.do" method="post" name ="frm" onsubmit="return doublechk()">
	
	<h1> 회원가입 </h1>

				<!-- 아이디 -->
				<div class="form-group">
						<input type="text" name="id" id="email" autofocus="autofocus" placeholder="아이디(이메일)" >
					<span class="form-group">
						<button class ="chk-btn" onclick="return chkId()"> 중복체크 </button>
						<!-- 아이디 중복체크 버튼 눌렀는지 체크 -->
<!-- 						<input type="hidden" name="check_id" value=""> -->
					</span>
					<div class="chk-msg" id ="err_id"></div>
				</div>

			<!-- 비밀번호 -->
				<div class="form-group">
					<input type="password" name="password" id="password" placeholder="비밀번호" required="required" onChange="chkPass()" >
					<input type="password" name="confirmPassword" placeholder="비밀번호 확인" required="required" onChange="chkPassword()">		
					<div class="chk-msg" id="err_pass"></div>
				</div>

				<!-- 닉네임 -->
				<div class="form-group">
					<input type="text" name="nickname" id="nickname" placeholder="닉네임" >
					<span class="form-group">
						<button class ="chk-btn" onclick="return chkNick()"> 중복체크 </button>
						<!-- 닉네임 중복체크 버튼 눌렀는지 체크 -->
<!-- 						<input type="hidden" name="checked_nick" value=""> -->
					</span>
					<div class="chk-msg" id="err_nm"></div>
				</div>
	
				<!-- OTT 목록 -->
				<div class="ott-select">
					<fieldset>
						<legend> 가입한 ott 목록</legend>
							
							<input type="checkbox" name="netflix" id="o1" value="Y">
							<label class="checkbox-inline">넷플릭스</label>
							<input type="checkbox" name="disney" id="o2" value="Y">
							<label class="checkbox-inline">디즈니+</label>
							<input type="checkbox" name="coupang" id="o3" value="Y">
							<label class="checkbox-inline">쿠팡플레이</label>
							<input type="checkbox" name="tving" id="o4" value="Y">
							<label class="checkbox-inline">티빙</label>
					</fieldset>
				</div>
				
				<br>
				<div class="form-group">
					<input type="submit" value="회원가입">
				</div>

	</form>
	</div>
</body>
</html>