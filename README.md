[레거시 시스템]: https://abasystem.co.kr
[:heavy_check_mark: 로그인]: https://abasystem.co.kr

# :house_with_garden: (주)아바 리뉴얼

![img](/readme-resources/main_page.png)

- 기존 **[레거시 시스템][]** 개선 및 기능 추가를 목표로 수행한 1인 프로젝트
- 프로젝트 기간 : `2020.11.01` ~ `2021.02.28 (퇴사)`

<br>

# :green_book: Contents

### [:one: Tech Stack](#one-tech-stack) <br>
### [:two: Package Structure](#two-package-structure) <br>
### [:three: Table diagram](#three-Table-relationship-diagram) <br>
### [:four: 기능 별 개발 방법](#four-기능-별-개발-방법) <br>

<br>

## :one: Tech Stack

<table class="tg">
<tbody>
<tr>
    <td><b>Architecture</b></td>
    <td>Spring MVC, Rest Api</td>
</tr>
<tr>
    <td><b>Network</b></td>
    <td>Embedded Tomcat, Gabia Cloud</td>
</tr>
<tr>
    <td><b>Dependency Injection</b></td>
    <td>Maven</td>
<tr>
    <td><b>Back-end</b></td>
    <td>Spring Security, Mybatis, Aws s3, Unit test</td>
</tr>
<tr>
    <td><b>Front-end</b></td>
    <td>Javascript, Jquery, Jsp & Jstl, Scss / css</td>
</tr>
<tr>
    <td><b>API</b></td>
    <td>Kakao map, Import (payment), Dropzone.js ...</td>
</tr>
<tr>
    <td><b>Database</b></td>
    <td>Mysql</td>
</tr>
<tr>
    <td><b>Other Tool</b></td>
    <td>Git issue, Slack, Navicat</td>
</tr>
</tbody>
</table>
<br>

## :two: Package Structure

```
📦 main
 ┣ 📂 com.abacorp.aba
 ┃ ┣ 📂 config
 ┃ ┣ 📂 core
 ┃ ┃ ┣ 📂 api
 ┃ ┃ ┣ 📂 controller
 ┃ ┃ ┣ 📂 service
 ┃ ┃ ┣ 📂 repository
 ┃ ┃ ┗ 📂 utils
 ┃ ┣ 📂 factory
 ┃ ┣ 📂 model
 ┃ ┗ 📂 security
 ┣ 📂 recources
 ┃ ┣ 📂 database
 ┃ ┃ ┗ 📂 sqlmap
 ┣ 📂 webapp
 ┃ ┣ 📂 WEB-INF
 ┃ ┃ ┗ 📂 jsp
 ┃ ┣ 📂 web-resources
 ┃ ┃ ┣ 📂 css
 ┃ ┃ ┣ 📂 font
 ┃ ┃ ┣ 📂 img
 ┃ ┃ ┣ 📂 js
 ┗ ┗ ┗ 📂 scss
 📦 test
 ...
```

<br>

## :three: Table Relationship diagram
![img](/readme-resources/diagram.png)

<br>

## :four: 기능 별 개발 방법


### [:heavy_check_mark: 지도와 필터링](https://github.com/woo-cher/aba-renewal/wiki/%EC%A7%80%EB%8F%84%EC%99%80-%ED%95%84%ED%84%B0%EB%A7%81) <br>

### [:heavy_check_mark: 지도 성능을 개선하기 위한 과정](https://github.com/woo-cher/aba-renewal/wiki/%EC%A7%80%EB%8F%84-%EC%84%B1%EB%8A%A5%EC%9D%84-%EA%B0%9C%EC%84%A0%ED%95%98%EA%B8%B0-%EC%9C%84%ED%95%9C-%EA%B3%BC%EC%A0%95)

### [:heavy_check_mark: Database Layer Access](https://github.com/woo-cher/aba-renewal/wiki/Database-Layer-Access) <br>

### [:heavy_check_mark: View 처리](https://github.com/woo-cher/aba-renewal/wiki/View-%EC%B2%98%EB%A6%AC) <br>

### [:heavy_check_mark: API 구현과 호출](https://github.com/woo-cher/aba-renewal/wiki/REST-API-%EB%B0%8F-%ED%98%B8%EC%B6%9C) <br>

### [:heavy_check_mark: User 권한 및 역할](https://github.com/woo-cher/aba-renewal/wiki/%EC%82%AC%EC%9A%A9%EC%9E%90-%EA%B6%8C%ED%95%9C-%EB%B0%8F-%EC%97%AD%ED%95%A0%EC%97%90-%EB%94%B0%EB%A5%B8-%ED%8E%98%EC%9D%B4%EC%A7%80-%EC%A0%91%EA%B7%BC-%EC%B2%98%EB%A6%AC)

### [:heavy_check_mark: Domain Type](https://github.com/woo-cher/aba-renewal/wiki/Domain-Type-%EB%B6%84%EB%A5%98) <br> 

### [:heavy_check_mark: 서버 유효성 검사](https://github.com/woo-cher/aba-renewal/wiki/%EC%84%9C%EB%B2%84-%EC%9C%A0%ED%9A%A8%EC%84%B1-%EA%B2%80%EC%82%AC) <br>

### [:heavy_check_mark: Validation](https://github.com/woo-cher/aba-renewal/wiki/Domain-Validation) <br>

