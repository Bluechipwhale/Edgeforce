// ==============================================================================
// EDGEWFORCE - STANDALONE STAFF DATASET IMPORT RUNNER
// Run via: node server/scripts/importStaffData.js
// ==============================================================================

import { staffImportService } from '../src/services/staffImportService.js';
import { logger } from '../src/utils/logger.js';

async function run() {
  logger.info('Starting authoritative staff dataset import...');
  const result = await staffImportService.importAuthoritativeStaff();
  logger.info('====================================================');
  logger.info('STAFF IMPORT SUMMARY:');
  logger.info(`Total records in source: ${result.total_records}`);
  logger.info(`Successfully processed: ${result.processed}`);
  logger.info(`Employees created: ${result.employees_created}`);
  logger.info(`Employees updated: ${result.employees_updated}`);
  logger.info(`Accounts created: ${result.accounts_created}`);
  logger.info(`Accounts updated: ${result.accounts_updated}`);
  logger.info(`Duplicates detected: ${result.duplicates_detected}`);
  logger.info(`Flagged for HR review: ${result.flagged_for_review}`);
  logger.info(`Errors encountered: ${result.errors.length}`);
  logger.info('====================================================');
  if (result.errors.length > 0) {
    logger.error(`Errors: ${JSON.stringify(result.errors, null, 2)}`);
  }
  process.exit(0);
}

run().catch((err) => {
  logger.error(`Import failed: ${err.message}`);
  process.exit(1);
});
