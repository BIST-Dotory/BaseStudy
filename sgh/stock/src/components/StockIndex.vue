<template>
    <div class="stock-index">
        <h1>주가지수 시세</h1>
        <ul>
            <li v-for="index in indices" :key="index.idxNm">
                {{ index.idxNm }}: {{ index.clpr }} (등락률: {{ index.fltRt }}%)
            </li>
        </ul>

        <div class="pagination">
            <button @click="prevPage" :disabled="pageNo <= 1">이전 페이지</button>
            <span>페이지 {{ pageNo }}</span>
            <button @click="nextPage">다음 페이지</button>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { ref, onMounted } from "vue";

export default {
    name: "StockIndex",
    setup() {
        const indices = ref([]);
        const pageNo = ref(1);
        const numOfRows = 10;
        const serviceKey = "b9Q8XIc4AR9x0WZSNe8njOPkMPMwc7cNxCCScSAa1PXnj/wpgR8iIRCcXKV91/1yVh+pBBfdXOZFkAkC47dlMQ==";

        const fetchIndices = async () => {
            try {
                const response = await axios.get(
                    "https://apis.data.go.kr/1160100/service/GetMarketIndexInfoService/getStockMarketIndex",
                    {
                        params: {
                            serviceKey,
                            pageNo: pageNo.value,
                            numOfRows,
                            resultType: "json",
                        },
                    }
                );

                console.log("API 응답 데이터:", response.data);
                const data = response.data?.response?.body?.items?.item;

                if (!data) {
                    console.error("유효한 데이터가 없습니다.");
                    indices.value = [];
                    return;
                }

                indices.value = data;
            } catch (error) {
                console.error("데이터를 불러오는데 실패했습니다:", error);
            }
        };

        const nextPage = () => {
            pageNo.value += 1;
            fetchIndices();
        };

        const prevPage = () => {
            if (pageNo.value > 1) {
                pageNo.value -= 1;
                fetchIndices();
            }
        };

        onMounted(fetchIndices);

        return {
            indices,
            pageNo,
            nextPage,
            prevPage,
        };
    },
};
</script>

<style>
</style>