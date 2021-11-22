#------------------------
# Builder Stage
# 'as builder' => 다음 FROM절 까지 Builder Stage 임을 명시
# 목표는 빌드파일을 생성하는 것!
# <WORKDIR>/build에 위치
#------------------------
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

CMD ["npm", "run", "build"]


#------------------------
# Run Stage
# Nginx를 가동
# 빌드된 파일들을 Nginx의 정적파일 관리 디렉토리(usr/share/nginx/html)에 복사
# 웹브라우져에서 Nginx에 요청 -> Nginx가 알맞은 정적 파일로 응답
#------------------------
FROM nginx

COPY --from=builder /usr/src/app/build usr/share/nginx/html