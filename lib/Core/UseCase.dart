
import 'package:fpdart/fpdart.dart';

import 'errors/failure.dart';



abstract interface class UseCase<success,Params>
{


  Future<Either<failure,success>> call(Params params);
}