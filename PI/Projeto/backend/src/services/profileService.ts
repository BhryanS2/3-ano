import { prisma } from "../prisma";

export class ProfileService {
  async execute(userId: number, data: any) {
    const profile = prisma.userProfile;
    const userProfile = await profile.findUnique({
      where: {
        id: userId,
      },
    });
  }
}
