class User {
  final String id;
  final String carnetNumber;
  final String name;
  final String email;
  final double walletBalance;
  final bool isMinor;
  final List<String> groupCodes;
  final List<CashbackTransaction>? transactions;
  final BankAccount? bankAccount;

  User({
    required this.id,
    required this.carnetNumber,
    required this.name,
    required this.email,
    required this.walletBalance,
    required this.isMinor,
    required this.groupCodes,
    this.transactions,
    this.bankAccount,
  });

  User copyWith({
    String? id,
    String? carnetNumber,
    String? name,
    String? email,
    double? walletBalance,
    bool? isMinor,
    List<String>? groupCodes,
    List<CashbackTransaction>? transactions,
    BankAccount? bankAccount,
  }) {
    return User(
      id: id ?? this.id,
      carnetNumber: carnetNumber ?? this.carnetNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      walletBalance: walletBalance ?? this.walletBalance,
      isMinor: isMinor ?? this.isMinor,
      groupCodes: groupCodes ?? this.groupCodes,
      transactions: transactions ?? this.transactions,
      bankAccount: bankAccount ?? this.bankAccount,
    );
  }
}

class CashbackTransaction {
  final String id;
  final String commerceName;
  final double amount;
  final double cashbackEarned;
  final DateTime date;
  final String status; // 'pending', 'approved', 'rejected'

  CashbackTransaction({
    required this.id,
    required this.commerceName,
    required this.amount,
    required this.cashbackEarned,
    required this.date,
    required this.status,
  });
}

class BankAccount {
  final String accountNumber;
  final String bankName;
  final String accountHolderName;

  BankAccount({
    required this.accountNumber,
    required this.bankName,
    required this.accountHolderName,
  });
}

class GroupCode {
  final String code;
  final String name;
  final String description;
  final double targetAmount;
  final double currentAmount;
  final DateTime endDate;
  final List<String> participants;
  final bool isSavingsCup;

  GroupCode({
    required this.code,
    required this.name,
    required this.description,
    required this.targetAmount,
    required this.currentAmount,
    required this.endDate,
    required this.participants,
    required this.isSavingsCup,
  });
}