import { Request, Response } from "express";
import { ProfileService } from "../services/profileService";

export class ProfileController {
  async handle(req: Request, res: Response) {
    try {
      const userId = Number(req.userId);
      const data = req.body;
      const service = new ProfileService();
      const response = await service.execute(userId, data);
      return res.json({ message: response, success: true });
    } catch (error) {
      return res.status(400).json({ message: error.message, success: false });
    }
  }
}
