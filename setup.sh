#!/bin/bash
set -e

echo "🚀 Base44 Clone 프로젝트 구조 생성 시작..."

# === 디렉토리 생성 ===
mkdir -p frontend/app frontend/components \
         backend/src/modules/{auth,crud,schema} \
         backend/src/ai backend/prisma \
         ai/{agents,prompts} \
         infra docs

# === 프론트엔드 기본 파일 ===
cat > frontend/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <main className="flex min-h-screen items-center justify-center">
      <h1 className="text-3xl font-bold">🚀 Base44 Clone - AI App Builder</h1>
    </main>
  )
}
EOF

cat > frontend/components/PromptBox.tsx << 'EOF'
export default function PromptBox() {
  return (
    <div className="p-4 border rounded-md">
      <input
        type="text"
        placeholder="Enter your app idea..."
        className="w-full p-2 border"
      />
    </div>
  )
}
EOF

cat > frontend/package.json << 'EOF'
{
  "name": "frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "tailwindcss": "^3.4.0"
  }
}
EOF

# === 백엔드 기본 파일 ===
cat > backend/src/main.ts << 'EOF'
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(4000);
  console.log(`🚀 Backend running on http://localhost:4000`);
}
bootstrap();
EOF

cat > backend/src/app.module.ts << 'EOF'
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [],
  providers: [],
})
export class AppModule {}
EOF

cat > backend/prisma/schema.prisma << 'EOF'
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "start": "nest start",
    "start:dev": "nest start --watch",
    "prisma": "prisma"
  },
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "prisma": "^5.0.0",
    "@prisma/client": "^5.0.0"
  }
}
EOF

# === AI 에이전트 설명 ===
cat > ai/agents/planner.md << 'EOF'
# Planner Agent
Prompt → JSON Schema 변환 담당
EOF

cat > ai/agents/codegen.md << 'EOF'
# CodeGen Agent
Schema → Backend CRUD + Frontend Page scaffold
EOF

cat > ai/agents/refiner.md << 'EOF'
# Refiner Agent
사용자 Feedback 반영 + Diff 업데이트
EOF

# === 인프라 기본 파일 ===
cat > infra/docker-compose.yml << 'EOF'
version: "3.9"
services:
  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppass
      POSTGRES_DB: appdb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.backend
    command: npm run start:dev
    ports:
      - "4000:4000"
    depends_on:
      - postgres

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.frontend
    command: npm run dev
    ports:
      - "3000:3000"
    depends_on:
      - backend

volumes:
  db_data:
EOF

cat > infra/Dockerfile.backend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]
EOF

cat > infra/Dockerfile.frontend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
EOF

# === 루트 문서 ===
cat > README.md << 'EOF'
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
#!/bin/bash
set -e

echo "🚀 Base44 Clone 프로젝트 구조 생성 시작..."

# === 디렉토리 생성 ===
mkdir -p frontend/app frontend/components \
         backend/src/modules/{auth,crud,schema} \
         backend/src/ai backend/prisma \
         ai/{agents,prompts} \
         infra docs

# === 프론트엔드 기본 파일 ===
cat > frontend/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <main className="flex min-h-screen items-center justify-center">
      <h1 className="text-3xl font-bold">🚀 Base44 Clone - AI App Builder</h1>
    </main>
  )
}
EOF

cat > frontend/components/PromptBox.tsx << 'EOF'
export default function PromptBox() {
  return (
    <div className="p-4 border rounded-md">
      <input
        type="text"
        placeholder="Enter your app idea..."
        className="w-full p-2 border"
      />
    </div>
  )
}
EOF

cat > frontend/package.json << 'EOF'
{
  "name": "frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "tailwindcss": "^3.4.0"
  }
}
EOF

# === 백엔드 기본 파일 ===
cat > backend/src/main.ts << 'EOF'
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(4000);
  console.log(`🚀 Backend running on http://localhost:4000`);
}
bootstrap();
EOF

cat > backend/src/app.module.ts << 'EOF'
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [],
  providers: [],
})
export class AppModule {}
EOF

cat > backend/prisma/schema.prisma << 'EOF'
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "start": "nest start",
    "start:dev": "nest start --watch",
    "prisma": "prisma"
  },
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "prisma": "^5.0.0",
    "@prisma/client": "^5.0.0"
  }
}
EOF

# === AI 에이전트 설명 ===
cat > ai/agents/planner.md << 'EOF'
# Planner Agent
Prompt → JSON Schema 변환 담당
EOF

cat > ai/agents/codegen.md << 'EOF'
# CodeGen Agent
Schema → Backend CRUD + Frontend Page scaffold
EOF

cat > ai/agents/refiner.md << 'EOF'
# Refiner Agent
사용자 Feedback 반영 + Diff 업데이트
EOF

# === 인프라 기본 파일 ===
cat > infra/docker-compose.yml << 'EOF'
version: "3.9"
services:
  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppass
      POSTGRES_DB: appdb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.backend
    command: npm run start:dev
    ports:
      - "4000:4000"
    depends_on:
      - postgres

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.frontend
    command: npm run dev
    ports:
      - "3000:3000"
    depends_on:
      - backend

volumes:
  db_data:
EOF

cat > infra/Dockerfile.backend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]
EOF

cat > infra/Dockerfile.frontend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
EOF

# === 루트 문서 ===
cat > README.md << 'EOF'
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
#!/bin/bash
set -e

echo "🚀 Base44 Clone 프로젝트 구조 생성 시작..."

# === 디렉토리 생성 ===
mkdir -p frontend/app frontend/components \
         backend/src/modules/{auth,crud,schema} \
         backend/src/ai backend/prisma \
         ai/{agents,prompts} \
         infra docs

# === 프론트엔드 기본 파일 ===
cat > frontend/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <main className="flex min-h-screen items-center justify-center">
      <h1 className="text-3xl font-bold">🚀 Base44 Clone - AI App Builder</h1>
    </main>
  )
}
EOF

cat > frontend/components/PromptBox.tsx << 'EOF'
export default function PromptBox() {
  return (
    <div className="p-4 border rounded-md">
      <input
        type="text"
        placeholder="Enter your app idea..."
        className="w-full p-2 border"
      />
    </div>
  )
}
EOF

cat > frontend/package.json << 'EOF'
{
  "name": "frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "tailwindcss": "^3.4.0"
  }
}
EOF

# === 백엔드 기본 파일 ===
cat > backend/src/main.ts << 'EOF'
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(4000);
  console.log(`🚀 Backend running on http://localhost:4000`);
}
bootstrap();
EOF

cat > backend/src/app.module.ts << 'EOF'
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [],
  providers: [],
})
export class AppModule {}
EOF

cat > backend/prisma/schema.prisma << 'EOF'
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "start": "nest start",
    "start:dev": "nest start --watch",
    "prisma": "prisma"
  },
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "prisma": "^5.0.0",
    "@prisma/client": "^5.0.0"
  }
}
EOF

# === AI 에이전트 설명 ===
cat > ai/agents/planner.md << 'EOF'
# Planner Agent
Prompt → JSON Schema 변환 담당
EOF

cat > ai/agents/codegen.md << 'EOF'
# CodeGen Agent
Schema → Backend CRUD + Frontend Page scaffold
EOF

cat > ai/agents/refiner.md << 'EOF'
# Refiner Agent
사용자 Feedback 반영 + Diff 업데이트
EOF

# === 인프라 기본 파일 ===
cat > infra/docker-compose.yml << 'EOF'
version: "3.9"
services:
  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppass
      POSTGRES_DB: appdb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.backend
    command: npm run start:dev
    ports:
      - "4000:4000"
    depends_on:
      - postgres

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.frontend
    command: npm run dev
    ports:
      - "3000:3000"
    depends_on:
      - backend

volumes:
  db_data:
EOF

cat > infra/Dockerfile.backend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]
EOF

cat > infra/Dockerfile.frontend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
EOF

# === 루트 문서 ===
cat > README.md << 'EOF'
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
#!/bin/bash
set -e

echo "🚀 Base44 Clone 프로젝트 구조 생성 시작..."

# === 디렉토리 생성 ===
mkdir -p frontend/app frontend/components \
         backend/src/modules/{auth,crud,schema} \
         backend/src/ai backend/prisma \
         ai/{agents,prompts} \
         infra docs

# === 프론트엔드 기본 파일 ===
cat > frontend/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <main className="flex min-h-screen items-center justify-center">
      <h1 className="text-3xl font-bold">🚀 Base44 Clone - AI App Builder</h1>
    </main>
  )
}
EOF

cat > frontend/components/PromptBox.tsx << 'EOF'
export default function PromptBox() {
  return (
    <div className="p-4 border rounded-md">
      <input
        type="text"
        placeholder="Enter your app idea..."
        className="w-full p-2 border"
      />
    </div>
  )
}
EOF

cat > frontend/package.json << 'EOF'
{
  "name": "frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "tailwindcss": "^3.4.0"
  }
}
EOF

# === 백엔드 기본 파일 ===
cat > backend/src/main.ts << 'EOF'
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(4000);
  console.log(`🚀 Backend running on http://localhost:4000`);
}
bootstrap();
EOF

cat > backend/src/app.module.ts << 'EOF'
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [],
  providers: [],
})
export class AppModule {}
EOF

cat > backend/prisma/schema.prisma << 'EOF'
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "start": "nest start",
    "start:dev": "nest start --watch",
    "prisma": "prisma"
  },
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "prisma": "^5.0.0",
    "@prisma/client": "^5.0.0"
  }
}
EOF

# === AI 에이전트 설명 ===
cat > ai/agents/planner.md << 'EOF'
# Planner Agent
Prompt → JSON Schema 변환 담당
EOF

cat > ai/agents/codegen.md << 'EOF'
# CodeGen Agent
Schema → Backend CRUD + Frontend Page scaffold
EOF

cat > ai/agents/refiner.md << 'EOF'
# Refiner Agent
사용자 Feedback 반영 + Diff 업데이트
EOF

# === 인프라 기본 파일 ===
cat > infra/docker-compose.yml << 'EOF'
version: "3.9"
services:
  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppass
      POSTGRES_DB: appdb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.backend
    command: npm run start:dev
    ports:
      - "4000:4000"
    depends_on:
      - postgres

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.frontend
    command: npm run dev
    ports:
      - "3000:3000"
    depends_on:
      - backend

volumes:
  db_data:
EOF

cat > infra/Dockerfile.backend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]
EOF

cat > infra/Dockerfile.frontend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
EOF

# === 루트 문서 ===
cat > README.md << 'EOF'
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
#!/bin/bash
set -e

echo "🚀 Base44 Clone 프로젝트 구조 생성 시작..."

# === 디렉토리 생성 ===
mkdir -p frontend/app frontend/components \
         backend/src/modules/{auth,crud,schema} \
         backend/src/ai backend/prisma \
         ai/{agents,prompts} \
         infra docs

# === 프론트엔드 기본 파일 ===
cat > frontend/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <main className="flex min-h-screen items-center justify-center">
      <h1 className="text-3xl font-bold">🚀 Base44 Clone - AI App Builder</h1>
    </main>
  )
}
EOF

cat > frontend/components/PromptBox.tsx << 'EOF'
export default function PromptBox() {
  return (
    <div className="p-4 border rounded-md">
      <input
        type="text"
        placeholder="Enter your app idea..."
        className="w-full p-2 border"
      />
    </div>
  )
}
EOF

cat > frontend/package.json << 'EOF'
{
  "name": "frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "tailwindcss": "^3.4.0"
  }
}
EOF

# === 백엔드 기본 파일 ===
cat > backend/src/main.ts << 'EOF'
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(4000);
  console.log(`🚀 Backend running on http://localhost:4000`);
}
bootstrap();
EOF

cat > backend/src/app.module.ts << 'EOF'
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [],
  providers: [],
})
export class AppModule {}
EOF

cat > backend/prisma/schema.prisma << 'EOF'
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "start": "nest start",
    "start:dev": "nest start --watch",
    "prisma": "prisma"
  },
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "prisma": "^5.0.0",
    "@prisma/client": "^5.0.0"
  }
}
EOF

# === AI 에이전트 설명 ===
cat > ai/agents/planner.md << 'EOF'
# Planner Agent
Prompt → JSON Schema 변환 담당
EOF

cat > ai/agents/codegen.md << 'EOF'
# CodeGen Agent
Schema → Backend CRUD + Frontend Page scaffold
EOF

cat > ai/agents/refiner.md << 'EOF'
# Refiner Agent
사용자 Feedback 반영 + Diff 업데이트
EOF

# === 인프라 기본 파일 ===
cat > infra/docker-compose.yml << 'EOF'
version: "3.9"
services:
  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: apppass
      POSTGRES_DB: appdb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.backend
    command: npm run start:dev
    ports:
      - "4000:4000"
    depends_on:
      - postgres

  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.frontend
    command: npm run dev
    ports:
      - "3000:3000"
    depends_on:
      - backend

volumes:
  db_data:
EOF

cat > infra/Dockerfile.backend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]
EOF

cat > infra/Dockerfile.frontend << 'EOF'
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "run", "dev"]
EOF

# === 루트 문서 ===
cat > README.md << 'EOF'
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

