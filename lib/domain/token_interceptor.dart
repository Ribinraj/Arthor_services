import 'package:dio/dio.dart';
import 'dart:developer';
import 'session_manager.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final responseData = response.data;
      
      // Only check for expired token message
      if (responseData is Map<String, dynamic>) {
        final message = responseData['message']?.toString().toLowerCase() ?? '';
        
        log('TokenInterceptor - Response message: $message');
        
        // Check if message contains "expired token"
        if (message.contains('expired token')) {
          log('🔒 Expired token detected - triggering session handler');
          SessionManager.handleExpiredToken(null);
          
          // Reject the request to prevent further processing
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              error: 'Session expired',
            ),
          );
          return;
        }
      }
    } catch (e) {
      log('Error in TokenInterceptor: $e');
    }
    
    super.onResponse(response, handler);
  }
}
