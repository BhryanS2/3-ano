"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Password = void 0;
const bcrypt = __importStar(require("bcrypt"));
class Password {
    async format(password) {
        if (!password)
            return false;
        const buffer = 10;
        const salt = await bcrypt.genSalt(buffer);
        const PasswordHash = await bcrypt.hash(password, salt);
        return PasswordHash;
    }
    isValid(password) {
        const expected = {
            minLength: 8,
            maxLength: 16,
            hasNumber: true,
            hasUpperCase: true,
            hasLowerCase: true,
            hasEspecialChar: true,
        };
        const passwordLength = password.length;
        const hasNumber = password.match(/\d/);
        const hasUpperCase = password.match(/[A-Z]/);
        const hasLowerCase = password.match(/[a-z]/);
        const hasEspecialChar = password.match(/[!@#$%&*()_+\-=\[\]{};':"\\|,.<>\/?]/);
        const isValid = {
            minLength: passwordLength >= expected.minLength,
            maxLength: passwordLength <= expected.maxLength && passwordLength > 0,
            hasNumber: !!hasNumber,
            hasUpperCase: !!hasUpperCase,
            hasLowerCase: !!hasLowerCase,
            hasEspecialChar: !!hasEspecialChar,
        };
        return isValid;
    }
    async comparePasswords(password, passwordHash) {
        if (!password)
            return false;
        const isValid = await bcrypt.compare(password, passwordHash);
        return isValid;
    }
    getErrorsMessages() {
        const expected = {
            minLength: "Password must be at least 8 characters",
            maxLength: "Password must be at most 16 characters",
            hasNumber: "Password must contain at least one number",
            hasUpperCase: "Password must contain at least one uppercase letter",
            hasLowerCase: "Password must contain at least one lowercase letter",
            hasEspecialChar: "Password must contain at least one special character",
        };
        const errorsMessages = {
            minLength: expected.minLength,
            maxLength: expected.maxLength,
            hasNumber: expected.hasNumber,
            hasUpperCase: expected.hasUpperCase,
            hasLowerCase: expected.hasLowerCase,
            hasEspecialChar: expected.hasEspecialChar,
        };
        return errorsMessages;
    }
}
exports.Password = Password;
