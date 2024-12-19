import 'package:fpdart/fpdart.dart';
import 'failure.dart';

typedef FutureEither<T>=Future<Either<Failure,T>>;
typedef FutureVoide=FutureEither<void>;

typedef FutureVoid = FutureEither;