package cat.durban.sergio.flutter_meta_appads_sdk.helper

import java.util.Currency
import java.util.Optional

object CurrencyFinder {
    private val AVAILABLE_CURRENCIES: Set<Currency> = Currency.getAvailableCurrencies()

    fun find(currencyCode: String): Optional<Currency> {
        return AVAILABLE_CURRENCIES.stream()
            .filter { currency -> currency.currencyCode == currencyCode }
            .findFirst()
    }

    fun find(numericCode: Int): Optional<Currency> {
        return AVAILABLE_CURRENCIES.stream()
            .filter { currency -> currency.numericCode == numericCode }
            .findFirst()
    }
}
