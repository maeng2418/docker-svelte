FROM node:alpine as builder

# work dir 를 만들기
RUN mkdir -p /usr/src/app

# work dir 고정
WORKDIR /usr/src/app

# NPM 설치
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY package*.json /usr/src/app/package.json
RUN npm install --silent

# 소스를 작업폴더로 복사하고 빌드
COPY . /usr/src/app
RUN npm run build


FROM nginx:alpine

# nginx의 기본 설정을 삭제
RUN rm -rf /etc/nginx/conf.d

# 앱의 nginx설정 파일을 아래 경로에 복사
COPY conf /etc/nginx

# 위에서 생성한 앱의 빌드산출물을 nginx의 샘플 앱이 사용하던 폴더로 이동
COPY --from=builder /usr/src/app/public /usr/share/nginx/html

# 80 포트 오픈
EXPOSE 80

# container 실행 시 자동으로 실행할 command. nginx 시작함
CMD ["nginx", "-g", "daemon off;"]