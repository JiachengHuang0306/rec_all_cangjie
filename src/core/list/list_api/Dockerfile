FROM swr.cn-north-4.myhuaweicloud.com/swr-devadv/cangjie:0.53.18-0
WORKDIR /app
EXPOSE 8080

ENV CANGJIE_HOME="/root/cangjie"
ENV PATH="/root/cangjie/bin:/root/cangjie/tools/bin:/root/.cjpm/bin:$PATH"
ENV LD_LIBRARY_PATH="/root/cangjie/runtime/lib/linux_x86_64_llvm:/root/cangjie/tools/lib"

COPY . .
WORKDIR src/core/list/list_api
RUN cjpm update
RUN cjpm build

ENTRYPOINT ["/app/src/core/list/list_api/target/release/bin/main"]