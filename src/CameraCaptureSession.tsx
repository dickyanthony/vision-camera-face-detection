import { NativeModules } from 'react-native';

interface CameraCaptureSessionInterface {
  configureCaptureSession(): void;
  stopCaptureSession(): void;
}

const { CameraCaptureSession } = NativeModules;

export default CameraCaptureSession as CameraCaptureSessionInterface;
