# Base44 Clone (AI App Builder)

## 실행 방법
```bash
# frontend
cd frontend
npm install
npm run dev

# backend
cd backend
npm install
npx prisma migrate dev
npm run start:dev

# infra (전체 실행)
docker-compose up --build

