FROM openjdk:8-jdk-alpine

#DEPENDENCY는 gradle에서 지정함. Dockerfile에서 선언하지 않을 경우 에러발생



# caution : ARG(DEPENDENCY, RUN_ENV)는 --build-arg로 파라미터로 받는다.
# gradle에서 buildArgs(['DEPENDENCY': "dependency", 'RUN_ENV': "dev"])로 전달받음
# Dockerfile에 해당 변수를 선언하지 않을 경우 값이 전달되지 않는다.


#ARG DEPENDENCY=build/dependency    : unpack에서는 build/dependency로 압축해제하는데 build를 지정할 경우 copy시 찾지 못함.
ARG DEPENDENCY=dependency
# ARG RUN_ENV=dev

COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app


EXPOSE 8080/tcp

# ENV RUN_ENV_PARAM=-Dspring.profiles.active=${RUN_ENV}
CMD java $RUN_ENV_PARAM -cp app:app/lib/* com.example.demo.DemoApplication

# ARG RUN_ENV_PARAM=-Dspring.profiles.active=${RUN_ENV}
# #CMD echo $RUN_ENV_PARAM
# RUN echo java -Dspring.profiles.active=${RUN_ENV} -cp app:app/lib/* wg.mdoauth.WgMdOauthApplication > startup.sh
# RUN chmod +x startup.sh
#ENTRYPOINT ["./startup.sh"]
#ENTRYPOINT ["java", "-cp","app:app/lib/*", "wg.mdoauth.WgMdOauthApplication"]
#ENTRYPOINT ["java", "$RUN_ENV_PARAM" ,"-cp","app:app/lib/*", "wg.mdoauth.WgMdOauthApplication"]
#ENTRYPOINT ["java", "-Dspring.profiles.active=local" ,"-cp","app:app/lib/*", "wg.mdoauth.WgMdOauthApplication"]




# RUN echo java -Dspring.profiles.active=${RUN_ENV} -cp app:app/lib/* wg.mdoauth.WgMdOauthApplication > startup.sh
# RUN chmod +x startup.sh
# CMD ./startup.sh
