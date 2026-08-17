import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  await prisma.user.upsert({
    where: { phoneNumber: '+910000000000' },
    update: {},
    create: {
      phoneNumber: '+910000000000',
      publicNidId: 'demo.nid',
      privateMailId: 'demo@email.nid',
      displayName: 'NID Demo',
    },
  });
}

main().finally(async () => {
  await prisma.$disconnect();
});
