import { prisma } from "../../prisma";

type challengeType = {
  id: number;
  type: string;
  description: string;
  amount: number;
};

export class EditChallengeService {
  async execute(data: challengeType, userId: string) {
    if (data.id === undefined || data.type === undefined) {
      throw new Error("id and type is required");
    }

    const user = await prisma.users.findFirst({
      where: {
        id: Number(userId),
      },
    });

    if (user.email !== process.env.ADMIN_EMAIL) {
      throw new Error("Method not allowed");
    }

    const challenge = await prisma.challenges.findFirst({
      where: {
        id: data.id,
      },
    });

    if (!challenge) {
      throw new Error("Challenge not found");
    }

    const response = await prisma.challenges.update({
      where: {
        id: data.id,
      },
      data: {
        type: data.type,
        description: data.description,
        amount: data.amount,
      },
    });

    return "Update Success";
  }
}
